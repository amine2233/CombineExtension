//
//  CombineControlProperty.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import Foundation
#if canImport(UIKit)
import UIKit.UIControl

public extension Publishers {
    struct ControlProperty<Control: UIControl, Value>: Publisher {
        public typealias Output = Value
        public typealias Failure = Never

        private let control: Control
        private let controlEvents: Control.Event
        private let keyPath: KeyPath<Control, Value>

        init(control: Control, events: Control.Event, keyPath: KeyPath<Control, Value>) {
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
}

extension Publishers.ControlProperty {
    private final class SubscriptionImp<S: Subscriber, Control: UIControl, Value>: Subscription where S.Input == Value {
        private var subscriber: S?
        weak private var control: Control?
        let keyPath: KeyPath<Control, Value>
        private var didEmitInitial = false

        init(subscriber: S, control: Control, event: Control.Event, keyPath: KeyPath<Control, Value>) {
            self.subscriber = subscriber
            self.control = control
            self.keyPath = keyPath
            control.addTarget(self, action: #selector(handleEvent), for: event)
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

extension UIControl.Event {
    static var defaultValueEvents: UIControl.Event {
        return [.allEditingEvents, .valueChanged]
    }
}
#endif
