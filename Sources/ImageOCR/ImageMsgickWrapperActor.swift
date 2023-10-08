//
//  File.swift
//  
//
//  Created by john on 2023/9/12.
//

import Foundation

@available(macOS 10.15.0, iOS 13, *)
public actor ImageMsgickWrapperActor {
    private var wrapper: ImageMsgickWrapper?

    public init() { }
    
    public init(_ source: ImageSourceProvider) {
        self.wrapper = ImageMsgickWrapper(source)
    }
    
    public func clear() {
        self.wrapper = nil
    }

    @discardableResult
    public func source(_ value: ImageSourceProvider) -> Self {
        wrapper = ImageMsgickWrapper(value)
        return self
    }
    
    /// 放大缩小图片
    /// - Parameter times: 放大倍数， 0-1.0
    @discardableResult
    public func scale(_ times: Double) throws -> Self {
        try wrapper?.scale(times)
        return self
    }
    
    /// 二值化图片
    @discardableResult
    public func threshold() throws -> Self {
        try wrapper?.threshold()
        return self
    }
    
    /// 转换色彩空间
    /// - Parameter colorSpace: 需要转换到的色彩空间
    @discardableResult
    public func transformColorspace(_ colorSpace: ImageMagickColorSpace) throws -> Self {
        try wrapper?.transformColorspace(colorSpace)
        return self
    }
    
    /// 保存图片文件
    /// - Parameter location: 新文件路径
    /// - Returns: 新文件路径
    @discardableResult
    public func export(to location: URL) throws -> URL {
        guard let wrapper = wrapper else {
            logger.error("ImageMsgickWrapperActor export to \(location) failed, wrapper is nil")
            throw InnerError.wandInvalid
        }
        return try wrapper.export(to: location)
    }
    
    /// 当前图片数据
    public func data() throws -> Data {
        guard let wrapper = wrapper else {
            logger.error("ImageMsgickWrapperActor data failed, wrapper is nil")
            throw InnerError.wandInvalid
        }
        return try wrapper.data()
    }
}
