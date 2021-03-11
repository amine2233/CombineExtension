//
//  File.swift
//  
//
//  Created by Amine Bensalah on 11/03/2021.
//

import Foundation

//: ## A Binding is just something that encapsulates getter+setter to a property
@propertyWrapper
public struct XBinding<Value> {
	public var wrappedValue: Value {
		get { return getValue() }
		nonmutating set { setValue(newValue) }
	}

	private let getValue: () -> Value
	private let setValue: (Value) -> Void

	public init(getValue: @escaping () -> Value, setValue: @escaping (Value) -> Void) {
		self.getValue = getValue
		self.setValue = setValue
	}

	public var projectedValue: Self { self }
}

//: -----------------------------------------------------------------
//: ## Transform Bindings
//: Usually in monad-land, we could declare a `map` method on XBinding for that
//: Except that here we need to be able to both get the name from the person... and be able to set it too
//: So instead of using a `transform` like classic `map`, we're gonna use a WritableKeyPath to be able to go both directions
public extension XBinding {
	func map<NewValue>(_ keyPath: WritableKeyPath<Value, NewValue>) -> XBinding<NewValue> {
		return XBinding<NewValue>(
			getValue: { self.wrappedValue[keyPath: keyPath] },
			setValue: { self.wrappedValue[keyPath: keyPath] = $0 }
		)
	}
}

//: -----------------------------------------------------------------
//: ## `@dynamicMemberLoopup`
//: Add dynamic member lookup capability (via protocol conformance) to forward any access to a property to the inner value
@dynamicMemberLookup
public protocol XBindingConvertible {
	associatedtype Value

	var binding: XBinding<Self.Value> { get }

	subscript<Subject>(dynamicMember keyPath: WritableKeyPath<Self.Value, Subject>) -> XBinding<Subject> { get }
}

extension XBindingConvertible {
	public subscript<Subject>(dynamicMember keyPath: WritableKeyPath<Self.Value, Subject>) -> XBinding<Subject> {
		return XBinding(
			getValue: { self.binding.wrappedValue[keyPath: keyPath] },
			setValue: { self.binding.wrappedValue[keyPath: keyPath] = $0 }
		)
	}
}

//: `XBinding` is one of those types on which we want that `@dynamicMemberLookup` feature:
public extension XBinding: XBindingConvertible {
	var binding: XBinding<Value> { self } // well for something already a `Binding`, just use itself!
}

