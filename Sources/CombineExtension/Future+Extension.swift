import Foundation

#if canImport(Combine)
import Combine

extension Future {
    // MARK: - Typealias
    /// Failure completion
    public typealias FailureCompletion = (Subscribers.Completion<Failure>) -> Void
    /// Success completion
    public typealias SuccessCompletion = (Output) -> Void

    // MARK: - Initialization
    /**
     Initialize a new `Future` with the provided `Result`.

     Example usage:
     ````
     let future = Future(result: Result.success(83))
     ````

     - Parameters:
        - result: The result of the `Future`. It can be a `Result` of success with a value or failure with an `Error`.

     - Returns: A new `Future`.
     */
    public convenience init(result: Result<Output, Failure>) {
        self.init { promise in
            promise(result)
        }
    }

    /**
     Initialize a new `Future` with the provided value.

     Example usage:
     ````
     let future = Future(value: 35)
     ````

     - Parameters:
        - value: The value of the `Future`.

     - Returns: A new `Future`.
     */
    public convenience init(value: Output) {
        self.init(result: .success(value))
    }

    /**
     Initialize a new `Future` with the provided `Error`.

     Example usage:
     ````
     let f: Future<Int>= Future(error: TypeError.error)
     ````
     - Parameters:
        - error: The error of the `Future`.

     - Returns: A new `Future`.
     */
    public convenience init(error: Failure) {
        self.init(result: .failure(error))
    }
}

extension Subscribers.Completion where Failure: Error {
    /// Get error value
    public var value: Optional<Failure> {
        switch self {
        case .failure(let error):
            return .some(error)
        default:
            return .none
        }
    }
}

#endif
