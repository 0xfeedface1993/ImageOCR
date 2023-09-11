//
//  File.swift
//  
//
//  Created by john on 2023/9/11.
//

import Foundation
import SwiftyTesseract

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Defines the possible errors
public enum URLSessionFutureErrors: Error {
    case invalidUrlResponse, missingResponseData
}

extension URLSession {
    @usableFromInline
    func futureData(from url: URLRequest) async throws -> (Data, URLResponse) {
#if canImport(FoundationNetworking)
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    continuation.resume(throwing: URLSessionFutureErrors.invalidUrlResponse)
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: URLSessionFutureErrors.missingResponseData)
                    return
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
#else
        return try await data(for: url)
#endif
    }
}

public protocol ImageDataProvider {
    func data() async throws -> Data
}

extension URL: ImageDataProvider {
    public func data() async throws -> Data {
        if isFileURL {
            return try Data(contentsOf: self)
        }
        return try await URLSession.shared.futureData(from: URLRequest(url: self)).0
    }
}

extension Data: ImageDataProvider {
    @inlinable
    public func data() async throws -> Data {
        self
    }
}

public actor TesseractWrapper {
    let dataProvider: ImageDataProvider
    public let language: RecognitionLanguage
    
    public init(_ dataProvider: ImageDataProvider, language: RecognitionLanguage) {
        self.dataProvider = dataProvider
        self.language = language
    }
    
    public func ocr() async throws -> String {
        let tesseract = Tesseract(language: language, dataSource: Bundle.module)
        let data = try await dataProvider.data()
        return try tesseract.performOCR(on: data).get()
    }
}
