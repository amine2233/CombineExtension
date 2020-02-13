import Foundation

/// A Protocol that represent `Result` type
public protocol ResultProtocol {

    associatedtype Success

    associatedtype Failure: Error

    /// Returns the associated value if the result is a success, `nil` otherwise.
    var value: Success? { get }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    var error: Failure? { get }

    /// Get Result value
    var result: Result<Success, Failure> { get }
}

extension Result: ResultProtocol where Failure: Error {

    /// Creates a new result with a success value.
    ///
    /// - Parameter value: A success value.
    public init(value: Success) {
        self = .success(value)
    }

    /// Creates a new result with a falure.
    ///
    /// - Parameter error: A failure value.
    public init(error: Failure) {
        self = .failure(error)
    }

    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Success? {
        switch self {
        case let .success(value):
            return value
        default:
            return nil
        }
    }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: Failure? {
        switch self {
        case let .failure(error):
            return error
        default:
            return nil
        }
    }

    /// Get Result value
    public var result: Result<Success, Failure> {
        return self
    }

    /// Test result if is success value
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    /// Test result if is failure value
    public var isFailure: Bool {
        switch self {
        case .failure:
            return true
        case .success:
            return false
        }
    }

    /// Returns a new Result by mapping `Success` values using `transform`, or re-wrapping `Failure` errors.
    public func map<NewSuccess>(_ transform: (Success) -> NewSuccess) -> Result<NewSuccess, Failure> {
        return flatMap { .success(transform($0)) }
    }

    public func flatMap<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> Result<NewSuccess, Failure> {
        return flatMap { value in
            do {
                return .success(try transform(value))
            } catch let error {
                return .failure(error as! Failure)
            }
        }
    }

    /// Returns a new Result by mapping `Failure` values using `transform`, or re-wrapping `Success` value.
    public func mapError<NewFailure>(_ transform: (Failure) -> NewFailure) -> Result<Success, NewFailure> where NewFailure: Error {
        return flatMapError { .failure(transform($0)) }
    }

    /// Returns the result of applying `transform` with optional value to `Success`es’ values,
    /// or re-wrapping `Failure`’s errors.
    public func compactMap<U>(_ transform: (Success?) -> U) -> Result<U, Failure> {
        switch self {
        case let .success(value): return .success(transform(value))
        case let .failure(error): return .failure(error)
        }
    }

    /// Returns a new Result by mapping `Failure`'s with optional value to `transform`,
    /// or re-wrapping `Success`’s errors.
    public func compactMapError<E: Swift.Error>(_ transform: (Failure?) -> E) -> Result<Success, E> {
        switch self {
        case let .success(value): return .success(value)
        case let .failure(error): return .failure(transform(error))
        }
    }

    /// Returns a new Result by mapping `Success`es’ values using `success`, and by mapping `Failure`'s values using `failure`.
    public func bimap<U, E>(success: (Success) -> U, failure: (Failure) -> E) -> Result<U, E> {
        switch self {
        case let .success(value): return .success(success(value))
        case let .failure(error): return .failure(failure(error))
        }
    }
}

// MARK: Result work with throws
extension Result {

    /// Return value or catch error
    public func convertThrow() throws -> Success {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
