import Foundation
import CImageMagick
import Logging

internal let logger = Logger(label: "com.image.magick.wrapper")

struct ImageMagickError: Error {
    let description: String
    let type: ImageMagickException
    let code: Int
}

enum InnerError: Error {
    case imageMagickExecption
    case wandInvalid
}

public final class ImageMsgickWrapper {
    private var wand: OpaquePointer?
    public var source: ImageSourceProvider
    private var imageLoaded = false
    
    public init(_ source: ImageSourceProvider) {
        MagickWandGenesis()
        self.wand = NewMagickWand()
        self.source = source
    }
    
    deinit {
        logger.info("ImageMsgickWrapper deinit")
        DestroyMagickWand(wand)
        MagickWandTerminus()
    }
    
    public func clear() {
        ClearMagickWand(wand)
        imageLoaded = false
    }
    
    @discardableResult
    public func source(_ value: ImageSourceProvider) -> Self {
        source = value
        imageLoaded = false
        return self
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
            MagickRelinquishMemory(buffer)
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
        guard let wand = wand else {
            throw InnerError.wandInvalid
        }
        
        try ImageOCR.exceptionWrapper(wand, action: action)
    }
    
    private func readImageIfNot() throws {
        if imageLoaded {
            logger.info("image already read \(source)")
            return
        }
        
        guard let wand = wand else {
            throw InnerError.wandInvalid
        }
        
        do {
            try source.load(from: wand)
            imageLoaded = true
        } catch {
            imageLoaded = false
            throw error
        }
    }
}
