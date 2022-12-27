//
//  File.swift
//  
//
//  Created by amine on 27/12/2022.
//

import Combine
#if canImport(SwiftUI)
import SwiftUI

/// A property wrapper type that reflects a value from `UserDefaults` and
/// invalidates a view on a change in value in that user default.
@frozen @propertyWrapper
public struct DefaultsStorage<Value: PropertyListValue>: DynamicProperty {

    @ObservedObject private var _value: DefaultsObservationStorage<Value>

    private init(
        value: Value,
        userDefaults: UserDefaults = .standard,
        key: UserDefaultsKey
    ) {
        _value = DefaultsObservationStorage(
            defaultValue: value,
            key: key,
            userDefaults: userDefaults
        )
    }

    public var wrappedValue: Value {
        get {
            _value.value
        }
        nonmutating set {
            _value.value = newValue
        }
    }

    public var projectedValue: Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { self.wrappedValue = $0 }
        )
    }

    public var publisher: AnyPublisher<Value, Never> {
        _value.publisher
    }
}

@usableFromInline
final class DefaultsObservationStorage<T: PropertyListValue>: NSObject, ObservableObject {
    var defaultValue: T
    let key: UserDefaultsKey
    var isDisposed: Bool = false
    var userDefaults: UserDefaults
    var value: T {
        get { userDefaults.value(forKey: key.rawValue) as? T ?? defaultValue }
        set { userDefaults.setValue(newValue, forKey: key.rawValue) }
    }
    var publisher: AnyPublisher<T, Never> { subject.eraseToAnyPublisher() }

    private var subject: CurrentValueSubject<T, Never>

    init(
        defaultValue: T,
        key: UserDefaultsKey,
        userDefaults: UserDefaults = .standard
    ) {
        self.defaultValue = defaultValue
        self.key = key
        self.userDefaults = userDefaults
        self.subject = CurrentValueSubject(defaultValue)
        super.init()
        self.userDefaults.addObserver(self, forKeyPath: key.rawValue, options: [.new], context: nil)
    }

    // swiftlint:disable block_based_kvo
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
        guard let change = change, object != nil, keyPath == key.rawValue else { return }
        let newValue = change[.newKey] as? T
        subject.send(newValue ?? defaultValue)
    }
    // swiftlint:enable block_based_kvo
}

#endif
