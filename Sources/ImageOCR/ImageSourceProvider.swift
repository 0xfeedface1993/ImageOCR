//
//  File.swift
//  
//
//  Created by john on 2023/9/12.
//

import Foundation

public protocol ImageSourceProvider {
    func load(from wand: OpaquePointer) throws
}

extension URL: ImageSourceProvider {
    public func load(from wand: OpaquePointer) throws {
        try ImageDataReader(wand: wand).loadURL(self)
    }
}

extension Data: ImageSourceProvider {
    public func load(from wand: OpaquePointer) throws {
        try ImageDataReader(wand: wand).loadData(self)
    }
}
