//
//  File.swift
//  
//
//  Created by Amine Bensalah on 11/03/2021.
//

import Foundation

//: -----------------------------------------------------------------
//: ## We don't want to declare storage ourselves: introducing `@State`
//: Ok this is all good and well, but remember our issue from the beginning? We still need to declare the storage for the value ourselves
//: Currently we had to declare `personStorage` and had to explicitly say how to get/set that storage when defining our `XBinding`.
//: That's no fun, so let's abstract this and wrap that one level further
//: `XState` will wrap both the storage for the value, and a `XBinding` to it
@propertyWrapper
public class CState<Value>: XBindingConvertible {
	public var wrappedValue: Value // the storage for the value
	public var binding: XBinding<Value> {
		// the binding to get/set the stored value
		XBinding(getValue: { self.wrappedValue }, setValue: { self.wrappedValue = $0 })
	}

	public init(wrappedValue value: Value) {
		self.wrappedValue = value
	}

	public var projectedValue: XBinding<Value> { binding }
}

//: -----------------------------------------------------------------
//: ## nonmutating set
//: Ok, but in Apple's API, State is a struct with a nonmutating setter. How did they achieve that then?
//: Well, just with one additional level of indirection, wrapping the class into a struct allows that trick:
@propertyWrapper
public struct XState<Value>: XBindingConvertible {
	class Storage {
		var value: Value
		init(initialValue: Value) { self.value = initialValue }
	}
	private var storage: Storage

	public var wrappedValue: Value {
		get { self.storage.value }
		nonmutating set { self.storage.value = newValue }
	}
	public var binding: XBinding<Value> {
		XBinding(getValue: { self.wrappedValue }, setValue: { self.wrappedValue = $0 })
	}

	public init(wrappedValue value: Value) {
		self.storage = Storage(initialValue: value)
	}

	public var projectedValue: XBinding<Value> { binding }
}
