//
//  CombineUserDefaultOnChange.swift
//  CombineExtension
//
//  Created by Amine Bensalah on 05/07/2020.
//

import Foundation
import Combine

public extension Publishers {
    struct DefaultsObservation<T: PropertyListValue>: Publisher {
        public typealias Output = T?
        public typealias Failure = Never

        private let userDefaults: UserDefaults
        private let key: Key

        public init(userDefaults: UserDefaults, key: Key) {
            self.userDefaults = userDefaults
            self.key = key
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = SubscriptionDefaultsObservation(
                subscriber: subscriber,
                userDefaults: userDefaults,
                key: key
            )
            subscriber.receive(subscription: subscription)
        }
    }
}

extension Publishers.DefaultsObservation {
    private final class SubscriptionDefaultsObservation<S: Subscriber, T: PropertyListValue>: NSObject, Subscription where S.Input == T? {
        private var subscriber: S?
        private var key: Key
        private var isDisposed: Bool = false
        private var userDefaults: UserDefaults

        init(subscriber: S, userDefaults: UserDefaults, key: Key) {
            self.subscriber = subscriber
            self.userDefaults = userDefaults
            self.key = key
            super.init()
            configure()
        }

        func request(_: Subscribers.Demand) {}

        func configure() {
            userDefaults.addObserver(self, forKeyPath: key.rawValue, options: [.new], context: nil)
        }

        // swiftlint:disable block_based_kvo
        override func observeValue(forKeyPath keyPath: String?,
                                   of object: Any?,
                                   change: [NSKeyValueChangeKey: Any]?,
                                   context _: UnsafeMutableRawPointer?) {
            guard let change = change, object != nil, keyPath == key.rawValue else { return }
            _ = subscriber?.receive(change[.newKey] as? T)
        }

        // swiftlint:enable block_based_kvo

        func cancel() {
            if !isDisposed {
                userDefaults.removeObserver(self, forKeyPath: key.rawValue, context: nil)
                isDisposed = true
                subscriber?.receive(completion: .finished)
            }
        }
    }
}
