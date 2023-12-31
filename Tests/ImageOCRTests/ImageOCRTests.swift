import XCTest
@testable import ImageOCR

#if os(macOS)
import CoreGraphics
#endif

final class ImageOCRTests: XCTestCase {
    func testScaleImage() async throws {
        let fileURL = Bundle.module.url(forResource: "QB8C", withExtension: "png")!
        let data = try Data(contentsOf: fileURL)
        let size = CGSize(width: 58, height: 22)
        let wrapper = ImageMsgickWrapperActor(data)
        
        let originImageData = try await wrapper.data()
        try await wrapper.scale(2)
        
#if os(macOS)
        let image = NSImage(data: try await wrapper.data())
        XCTAssertEqual(image?.size.width, size.width * 2)
#endif
        try await wrapper.threshold()
        try await wrapper.scale(0.8)
        let lastImageData = try await wrapper.data()
        XCTAssertNotEqual(originImageData.count, lastImageData.count)
        let tesseract = TesseractWrapper(lastImageData, language: .english)
        let text = try await tesseract.ocr()
        XCTAssertEqual(text, "QB8C")
    }
}
