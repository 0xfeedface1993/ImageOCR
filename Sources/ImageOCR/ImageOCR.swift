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
    
    init(_ fileURL: URL) {
        self.wrapper = ImageMsgickWrapper(fileURL)
    }
    
    /// 放大缩小图片
    /// - Parameter times: 放大倍数， 0-1.0
    @discardableResult
    func scale(_ times: Double) throws -> Self {
        try wrapper.scale(times)
        return self
    }
    
    /// 二值化图片
    /// - Parameter rawPercentage: 阈值，0-1.0，对应0-255
    @discardableResult
    func threshold(_ rawPercentage: Double) throws -> Self {
        try wrapper.threshold(rawPercentage)
        return self
    }
    
    /// 转换色彩空间
    /// - Parameter colorSpace: 需要转换到的色彩空间
    @discardableResult
    func transformColorspace(_ colorSpace: ImageMagickColorSpace) throws -> Self {
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
    let fileURL: URL
    private var imageLoaded = false
    
    init(_ fileURL: URL) {
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
    func scale(_ times: Double) throws -> Self {
        try exceptionWrapper {
            try readImageIfNot()
            let factor = fabs(times)
            let width = Int(ceil(factor * Double(MagickGetImageWidth(wand))))
            let height = Int(ceil(factor * Double(MagickGetImageHeight(wand))))
            return MagickResizeImage(wand, width, height, LanczosFilter)
        }
        return self
    }
    
    /// 二值化图片
    /// - Parameter rawPercentage: 阈值，0-1.0，对应0-255
    @discardableResult
    func threshold(_ rawPercentage: Double) throws -> Self {
        try exceptionWrapper {
            let percentage = min(1, max(rawPercentage, 0))
            let value = 255.0 * Double(percentage)
            
            try readImageIfNot()
            
            MagickSetColorspace(wand, ImageMagickColorSpace.RGBColorspace.rawValue)
            
            return MagickThresholdImage(wand, value)
        }        
        return self
    }
    
    /// 转换色彩空间
    /// - Parameter colorSpace: 需要转换到的色彩空间
    @discardableResult
    func transformColorspace(_ colorSpace: ImageMagickColorSpace) throws -> Self {
        try exceptionWrapper {
            try readImageIfNot()
            try exceptionWrapper({
                MagickSetType(wand, TrueColorType)
            })
            return MagickTransformImageColorspace(wand, colorSpace.rawValue)
        }
        return self
    }
    
    /// 当前图片数据
    func data() throws -> Data {
        var data: Data!
        try exceptionWrapper {
            try readImageIfNot()
            var size: Int = 0
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

