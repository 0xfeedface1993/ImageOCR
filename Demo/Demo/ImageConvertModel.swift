//
//  ImageConvertModel.swift
//  Demo
//
//  Created by john on 2023/9/11.
//

import Foundation
import Combine
import CoreGraphics
import ImageOCR
import AppKit

final class ImageConvertModel: ObservableObject {
    let worker = ImageMsgickWrapperActor(Bundle.main.url(forResource: "QB8C", withExtension: "png")!)
    @Published var image: CGImage?
    
    func scale() {
        Task {
            do {
                try await worker.scale(2)
                try await self.reloadImage()
            } catch {
                print(">>> \(#function) failed, \(error)")
            }
            
        }
    }
    
    @MainActor
    func reloadImage() async throws {
        do {
            let data = try await worker.data()
            self.image = NSImage(data: data)?.cgImage(forProposedRect: nil, context: nil, hints: nil)
        } catch {
            print(">>> \(#function) failed, \(error)")
            await emptyImage()
        }
    }
    
    @MainActor
    func emptyImage() async {
        self.image = nil
    }
}
