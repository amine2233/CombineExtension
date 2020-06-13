import XCTest
@testable import CombineExtension

final class CancellableExtensionTests: XCTestCase {

    func testNonCancellable() {

        let cancellableBlock = NonCancellable.instance

        cancellableBlock.cancel()

        XCTAssertNotNil(cancellableBlock)
    }

    func testBlockCancellable() {
        var value: String = ""
        let handler = {
            value = "finish"
        }
        let cancellableBlock = BlockCancellable(handler)

        cancellableBlock.cancel()
        XCTAssertEqual(value, "finish")
    }

    static var allTests = [
        ("testNonCancellable", testNonCancellable),
        ("testBlockCancellable", testBlockCancellable),
    ]
}
