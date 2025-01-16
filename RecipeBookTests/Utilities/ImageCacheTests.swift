import XCTest
@testable import RecipeBook

final class ImageCacheTests: XCTestCase {

    func testImageCacheSetAndGet() {
        // Given
        let cache = ImageCache.shared
        let testURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg")!
        let testImage = UIImage(systemName: "fork.knife.circle")!

        // When
        cache.setImage(testImage, for: testURL)
        let cachedImage = cache.image(for: testURL)

        // Then
        XCTAssertNotNil(cachedImage)
        XCTAssertEqual(cachedImage, testImage)
    }

    func testImageCacheMiss() {
        // Given
        let cache = ImageCache.shared
        let testURL = URL(string: "https://example.com/missing.png")!

        // When
        let cachedImage = cache.image(for: testURL)

        // Then
        XCTAssertNil(cachedImage)
    }
}
