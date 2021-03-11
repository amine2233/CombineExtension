import Foundation
import Combine

@propertyWrapper
struct Input<Value> {
	var wrappedValue: Value {
		get { subject.value }
		set { subject.send(newValue) }
	}

	var projectedValue: AnyPublisher<Value, Never> {
		subject.eraseToAnyPublisher()
	}

	private let subject: CurrentValueSubject<Value, Never>

	init(wrappedValue: Value) {
		subject = CurrentValueSubject(wrappedValue)
	}
}
