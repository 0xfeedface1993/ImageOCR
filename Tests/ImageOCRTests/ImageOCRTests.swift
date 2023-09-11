import XCTest
@testable import ImageOCR

#if os(macOS)
import CoreGraphics
#endif

final class ImageOCRTests: XCTestCase {
    func testScaleImage() async throws {
        let fileURL = Bundle.module.url(forResource: "QB8C", withExtension: "png")!
        let size = CGSize(width: 58, height: 22)
        let wrapper = ImageMsgickWrapperActor(fileURL)
        
        try await wrapper.scale(2)
#if os(macOS)
        var image = NSImage(data: try await wrapper.data())
        XCTAssertEqual(image?.size.width, size.width * 2)
#endif
        
        try await wrapper.threshold(0.5)
        try await wrapper.transformColorspace(.RGBColorspace)
        try await wrapper.scale(0.5)
        
#if os(macOS)
        image = NSImage(data: try await wrapper.data())
        XCTAssertEqual(image?.size.width, size.width)
#endif
    }
}
