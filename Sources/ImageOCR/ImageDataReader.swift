//
//  File.swift
//  
//
//  Created by john on 2023/9/12.
//

import Foundation
import CImageMagick

struct ImageDataReader {
    let wand: OpaquePointer
    
    func loadURL(_ fileURL: URL) throws {
        try exceptionWrapper(wand, action: {
            try fileURL.withUnsafeFileSystemRepresentation {
                guard let pointer = $0 else {
                    throw ImageMagickError(description: "access file \(fileURL) failed.", type: .invalidFileSystemRepresentation(fileURL), code: -2)
                }
                
                return MagickReadImage(wand, pointer)
            }
        })
    }
    
    func loadData(_ data: Data) throws {
        try exceptionWrapper(wand, action: {
            data.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) in
                MagickReadImageBlob(wand, pointer.baseAddress, data.count)
            }
        })
    }
}

func exceptionWrapper(_ wand: OpaquePointer,  action: () throws -> MagickBooleanType) throws {
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
