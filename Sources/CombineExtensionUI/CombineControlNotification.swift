//
//  CombineControlNotification.swift
//  UICombineExtension
//
//  Created by Amine Bensalah on 14/06/2020.
//

import Foundation
import Combine

public extension Publishers {
    struct CombineControlNotification: Publisher {
        public typealias Output = Notification
        public typealias Failure = Never

        private let notification: NotificationCenter
        private let name: Notification.Name
        private var object: AnyObject?

        public init(notification: NotificationCenter = .default, name: Notification.Name, object: AnyObject? = nil) {
            self.notification = notification
            self.name = name
            self.object = object
        }

        public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SubscriptionNotification(subscriber: subscriber, notification: notification, name: name, object: object)
            subscriber.receive(subscription: subscription)
        }
    }

    struct CombineControlNotificationKeyPath<Value>: Publisher {
        public typealias Output = Value
        public typealias Failure = Never

        private let notification: NotificationCenter
        private let keyPath: KeyPath<NotificationCenter, Value>

        public init(notification: NotificationCenter = .default, for keyPath: KeyPath<NotificationCenter, Value>) {
            self.notification = notification
            self.keyPath = keyPath
        }

        public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SubscriptionNotification(subscriber: subscriber, notification: notification, keyPath: keyPath)
            subscriber.receive(subscription: subscription)
        }
    }

    struct CombineControlNotificationKeyPathOption<Value>: Publisher {
        public typealias Output = Value
        public typealias Failure = Never

        private let notification: NotificationCenter
        private let keyPath: KeyPath<NotificationCenter, Value>
        private let options: NSKeyValueObservingOptions

        public init(notification: NotificationCenter = .default, for keyPath: KeyPath<NotificationCenter, Value>, options: NSKeyValueObservingOptions) {
            self.notification = notification
            self.keyPath = keyPath
            self.options = options
        }

        public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SubscriptionNotification(subscriber: subscriber, notification: notification, keyPath: keyPath, options: options)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension Publishers.CombineControlNotification {
    private final class SubscriptionNotification<S: Subscriber>: Subscription where S.Input == Notification {
        private var subscriber: S?
        private let notification: NotificationCenter
        private var bag = Set<AnyCancellable>()

        init(subscriber: S, notification: NotificationCenter, name: Notification.Name, object: AnyObject?) {
            self.subscriber = subscriber
            self.notification = notification
            notification.publisher(for: name, object: object)
                .sink {[weak self] notification in
                    _ = self?.subscriber?.receive(notification)
                }
                .store(in: &bag)
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            subscriber = nil
        }
    }
}

extension Publishers.CombineControlNotificationKeyPath {
    private final class SubscriptionNotification<S: Subscriber, Value>: Subscription where S.Input == Value {
        private var subscriber: S?
        private let notification: NotificationCenter
        private var bag = Set<AnyCancellable>()

        init(subscriber: S, notification: NotificationCenter, keyPath: KeyPath<NotificationCenter, Value>) {
            self.subscriber = subscriber
            self.notification = notification
            notification
                .publisher(for: keyPath)
                .sink {[weak self] value in
                    _ = self?.subscriber?.receive(value)
                }
                .store(in: &bag)
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            subscriber = nil
        }
    }
}

extension Publishers.CombineControlNotificationKeyPathOption {
    private final class SubscriptionNotification<S: Subscriber, Value>: Subscription where S.Input == Value {
        private var subscriber: S?
        private let notification: NotificationCenter
        private var bag = Set<AnyCancellable>()

        init(subscriber: S, notification: NotificationCenter, keyPath: KeyPath<NotificationCenter, Value>, options: NSKeyValueObservingOptions) {
            self.subscriber = subscriber
            self.notification = notification
            notification
                .publisher(for: keyPath, options: options)
                .sink {[weak self] value in
                    _ = self?.subscriber?.receive(value)
                }
                .store(in: &bag)
        }

        func request(_ demand: Subscribers.Demand) {
        }

        func cancel() {
            subscriber = nil
        }
    }
}
