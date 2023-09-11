import Foundation
import CImageMagick
import Logging

fileprivate let logger = Logger(label: "com.image.magick.wrapper")

struct ImageMagickError: Error {
    let description: String
    let type: ImageMagickException
    let code: Int
}

enum InnerError: Error {
    case imageMagickExecption
}

@available(macOS 10.15.0, iOS 13, *)
public actor ImageMsgickWrapperActor {
    private let wrapper: ImageMsgickWrapper
    
    public init(_ fileURL: URL) {
        self.wrapper = ImageMsgickWrapper(fileURL)
    }
    
    /// 放大缩小图片
    /// - Parameter times: 放大倍数， 0-1.0
    @discardableResult
    public func scale(_ times: Double) throws -> Self {
        try wrapper.scale(times)
        return self
    }
    
    /// 二值化图片
    @discardableResult
    public func threshold() throws -> Self {
        try wrapper.threshold()
        return self
    }
    
    /// 转换色彩空间
    /// - Parameter colorSpace: 需要转换到的色彩空间
    @discardableResult
    public func transformColorspace(_ colorSpace: ImageMagickColorSpace) throws -> Self {
        try wrapper.transformColorspace(colorSpace)
        return self
    }
    
    /// 保存图片文件
    /// - Parameter location: 新文件路径
    /// - Returns: 新文件路径
    @discardableResult
    public func export(to location: URL) throws -> URL {
        try wrapper.export(to: location)
    }
    
    /// 当前图片数据
    public func data() throws -> Data {
        try wrapper.data()
    }
}

public final class ImageMsgickWrapper {
    private var wand: OpaquePointer?
    public let fileURL: URL
    private var imageLoaded = false
    
    public init(_ fileURL: URL) {
        MagickWandGenesis()
        self.wand = NewMagickWand()
        self.fileURL = fileURL
    }
    
    deinit {
        if let wand = self.wand {
            DestroyMagickWand(wand)
        }
        MagickWandTerminus()
    }
    
    /// 放大缩小图片
    /// - Parameter times: 放大倍数， 0-1.0
    @discardableResult
    public func scale(_ times: Double) throws -> Self {
        try readImageIfNot()
        let factor = fabs(times)
        let width = Int(ceil(factor * Double(MagickGetImageWidth(wand))))
        let height = Int(ceil(factor * Double(MagickGetImageHeight(wand))))
        try exceptionWrapper {
            MagickResizeImage(wand, width, height, UndefinedFilter)
        }
        return self
    }
    
    /// 二值化图片
    @discardableResult
    public func threshold() throws -> Self {
        try readImageIfNot()
        
        try exceptionWrapper {
            MagickAutoThresholdImage(wand, KapurThresholdMethod)
        }
        
        try transformColorspace(.RGBColorspace)
        try setColorSpace(.RGBColorspace)
        try setImageType(TrueColorType)
        
        return self
    }
    
    /// 转换色彩空间
    /// - Parameter colorSpace: 需要转换到的色彩空间
    @discardableResult
    public func transformColorspace(_ colorSpace: ImageMagickColorSpace) throws -> Self {
        try readImageIfNot()
        try exceptionWrapper {
            MagickTransformImageColorspace(wand, colorSpace.rawValue)
        }
        return self
    }
    
    /// 当前图片数据
    public func data() throws -> Data {
        var data: Data!
        try readImageIfNot()
        var size: Int = 0
        try exceptionWrapper {
            guard let buffer = MagickGetImageBlob(wand, &size) else {
                return MagickFalse
            }
            data = Data(bytes: buffer, count: size)
            return MagickTrue
        }
        return data
    }
    
    /// 保存图片文件
    /// - Parameter location: 新文件路径
    /// - Returns: 新文件路径
    @discardableResult
    public func export(to location: URL) throws -> URL {
        try exceptionWrapper {
            try location.withUnsafeFileSystemRepresentation {
                guard let pointer = $0 else {
                    throw ImageMagickError(description: "access file \(location) failed.", type: .invalidFileSystemRepresentation(location), code: -2)
                }
                return MagickWriteImage(wand, pointer)
            }
        }
        return location
    }
    
    func setColorSpace(_ colorSpace: ImageMagickColorSpace = .RGBColorspace) throws {
        try exceptionWrapper({
            MagickSetColorspace(wand, colorSpace.rawValue)
        })
    }
    
    func setImageType(_ imageType: ImageType) throws {
        try exceptionWrapper({
            MagickSetType(wand, imageType)
        })
    }
    
    private func exceptionWrapper(_ action: () throws -> MagickBooleanType) throws {
        do {
            let status = try action()
            if status == MagickFalse {
                let exceptionType = UnsafeMutablePointer<ExceptionType>.allocate(capacity: 1)
                if let exception = MagickGetException(wand, exceptionType) {
                    logger.info("image magick execption exists: \(exception), throw error")
                    throw ImageMagickError(description: String(cString: exception), type: .init(exceptionType.pointee), code: -1)
                }
                logger.info("no imageMagickExecption exists, not throw any error")
            }
        } catch {
            throw error
        }
    }
    
    private func readImageIfNot() throws {
        if imageLoaded {
            logger.info("image already read \(fileURL)")
            return
        }
        
        try exceptionWrapper {
            try fileURL.withUnsafeFileSystemRepresentation {
                guard let pointer = $0 else {
                    throw ImageMagickError(description: "access file \(fileURL) failed.", type: .invalidFileSystemRepresentation(fileURL), code: -2)
                }
                
                let status = MagickReadImage(wand, pointer)
                guard status == MagickTrue else {
                    imageLoaded = false
                    return status
                }
                imageLoaded = true
                return status
            }
        }
    }
}

