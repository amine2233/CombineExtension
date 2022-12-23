import Foundation
import Combine

#if canImport(XCTest)
import XCTest

public extension XCTestCase {
	/// - Seealso: https://www.swiftbysundell.com/articles/unit-testing-combine-based-swift-code/
	func awaitPublisher<T: Publisher>(
		_ publisher: T,
		timeout: TimeInterval = 10,
		file: StaticString = #file,
		line: UInt = #line) throws -> T.Output {
		// This time, we use Swift's Result type to keep track
		// of the result of our Combine pipeline:
		var result: Result<T.Output, Error>?
		let expectation = self.expectation(description: "Awaiting publisher")

		let cancellable = publisher
			.sink { completion in
				switch completion {
				case let .failure(error):
					result = .failure(error)
				case .finished:
					break
				}
				expectation.fulfill()
		} receiveValue: { (value) in
			result = .success(value)
		}

		waitForExpectations(timeout: timeout)
		cancellable.cancel()

		let unwrappedResult = try XCTUnwrap(
			result,
			"Awaited publisher did not produce any output",
			file: file,
			line: line
		)

		return try unwrappedResult.get()
	}
}
#endif
