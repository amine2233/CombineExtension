import XCTest
@testable import FutureExt

class ResultExtensionsTests: XCTestCase {

    enum TestError: Error {
        case empty
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsSuccess() {
        let result = Result<Int, TestError>(value: 56)

        XCTAssertTrue(result.isSuccess)
    }

    func testIsNotSuccess() {
        let result = Result<Int, TestError>(error: .empty)

        XCTAssertFalse(result.isSuccess)
    }

    func testResultValue() {
        let result = Result<Int, TestError>(value: 56)

        XCTAssertEqual(result.result, result)
    }

    func testValueSuccess() {
        let result = Result<Int, TestError>(value: 56)

        XCTAssertEqual(result.value, 56)
    }

    func testValueSuccessNil() {
        let result = Result<Int, TestError>(error: .empty)

        XCTAssertNil(result.value)
    }

    func testFailureValueNil() {
        let result = Result<Int, TestError>(value: 56)

        XCTAssertNil(result.error)
    }

    func testFailureValue() {
        let result = Result<Int, TestError>(error: .empty)

        XCTAssertEqual(result.error, .empty)
    }

    func testIsNotFailure() {
        let result = Result<Int, TestError>(value: 56)

        XCTAssertFalse(result.isFailure)
    }

    func testIsFailure() {
        let result = Result<Int, TestError>(error: .empty)

        XCTAssertTrue(result.isFailure)
    }

    func testConvertThrowSuccess() {
        let result = Result<Int, TestError>(value: 56)

        XCTAssertNoThrow(try result.convertThrow())
    }

    func testConvertThrowFailure() {
        let result = Result<Int, TestError>(error: .empty)

        XCTAssertThrowsError(try result.convertThrow())
    }

    func testCompactMapSuccess() {
        let result = Result<Int, TestError>(value: 56)

        let newResult = result.compactMap { "\($0 ?? 6)" }

        XCTAssertEqual("56", newResult.value)
    }

    func testCompactMapError() {
        let result = Result<Int, TestError>(error: .empty)

        let newResult = result.compactMap { "\($0 ?? 6)" }

        XCTAssertFalse(newResult.isSuccess)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
