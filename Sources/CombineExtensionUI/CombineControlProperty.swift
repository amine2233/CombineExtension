import Combine
import Foundation
#if canImport(UIKit)
import UIKit.UIControl
public typealias Control = UIControl
public typealias Event = UIControl.Event
#elseif canImport(AppKit)
import AppKit.NSControl
public typealias Control = NSControl
public typealias Event = NSControl.StateValue
#endif

public extension Publishers {
    struct ControlProperty<Object: Control, Value>: Publisher {
        public typealias Output = Value
        public typealias Failure = Never

        private let control: Object
        private let controlEvents: Event
        private let keyPath: KeyPath<Object, Value>

        init(control: Object, events: Event, keyPath: KeyPath<Object, Value>) {
            self.control = control
            self.controlEvents = events
            self.keyPath = keyPath
        }

        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = SubscriptionImp(subscriber: subscriber,
                                               control: control,
                                               event: controlEvents,
                                               keyPath: keyPath)
            subscriber.receive(subscription: subscription)
        }
    }

    struct ControlEvent<Object: Control>: Publisher {
        public typealias Output = Void
        public typealias Failure = Never

        private let control: Object
        private let controlEvents: Event

        public init(control: Object, events: Event) {
            self.control = control
            self.controlEvents = events
        }

        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = SubscriptionImp(subscriber: subscriber,
                                               control: control,
                                               event: controlEvents)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension Publishers.ControlProperty {
    private final class SubscriptionImp<S: Subscriber, Object: Control, Value>: Subscription where S.Input == Value {
        private var subscriber: S?
        weak private var control: Object?
        let keyPath: KeyPath<Object, Value>
        private var didEmitInitial = false

        init(subscriber: S, control: Object, event: Event, keyPath: KeyPath<Object, Value>) {
            self.subscriber = subscriber
            self.control = control
            self.keyPath = keyPath
            #if os(iOS)
                control.addTarget(self, action: #selector(handleEvent), for: event)
            #elseif os(OSX)
                control.sendAction(#selector(handleEvent), to: self)
            #endif
        }

        func request(_ demand: Subscribers.Demand) {
            if !didEmitInitial,
                demand > .none,
                let control = control,
                let subscriber = subscriber {
                _ = subscriber.receive(control[keyPath: keyPath])
                didEmitInitial = true
            }
        }

        func cancel() {
            subscriber = nil
        }

        @objc private func handleEvent() {
            guard let control = control else { return }
            _ = subscriber?.receive(control[keyPath: keyPath])
        }
    }
}

extension Publishers.ControlEvent {
    private final class SubscriptionImp<S: Subscriber, Object: Control>: Subscription where S.Input == Void {
        private var subscriber: S?
        weak private var control: Object?

        init(subscriber: S, control: Object, event: Event) {
            self.subscriber = subscriber
            self.control = control
            #if os(iOS)
                control.addTarget(self, action: #selector(handleEvent), for: event)
            #elseif os(OSX)
                control.sendAction(#selector(handleEvent), to: self)
            #endif
        }

        func request(_ demand: Subscribers.Demand) {
        }

        func cancel() {
            subscriber = nil
        }

        @objc private func handleEvent() {
            _ = subscriber?.receive()
        }
    }
}
