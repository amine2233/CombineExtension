import Foundation

#if canImport(Combine)
import Combine

extension Publisher {
    /// - seealso: https://twitter.com/peres/status/1136132104020881408
    public func flatMapLatest<T: Publisher>(_ transform: @escaping (Self.Output) -> T) -> Publishers.SwitchToLatest<T, Publishers.Map<Self, T>> where T.Failure == Self.Failure {
        map(transform).switchToLatest()
    }
}

extension Publisher {
    public static func empty() -> AnyPublisher<Output, Failure> {
        return Empty()
            .eraseToAnyPublisher()
    }

    public static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }

    public static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}

public extension Published.Publisher {
	func collectNext(_ count: Int) -> AnyPublisher<[Output], Never> {
		self.dropFirst()
			.collect(count)
			.first()
			.eraseToAnyPublisher()
	}
}

public extension Publisher where Failure == Never {
	/// - seealso: https://www.swiftbysundell.com/articles/combine-self-cancellable-memory-management/
	func weakAssign<T: AnyObject>(to keyPath: ReferenceWritableKeyPath<T, Output>, on object: T) -> AnyCancellable {
		sink { [weak object] value in
			object?[keyPath: keyPath] = value
		}
	}
}

#endif
