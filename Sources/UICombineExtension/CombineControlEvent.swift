import Foundation
import Combine
#if canImport(UIKit)
import UIKit.UIControl

public extension Publishers {

    struct ControlEvent<Control: UIControl>: Publisher {
        public typealias Output = Void
        public typealias Failure = Never

        private let control: Control
        private let controlEvents: Control.Event

        public init(control: Control, events: Control.Event) {
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

extension Publishers.ControlEvent {
    private final class SubscriptionImp<S: Subscriber, Control: UIControl>: Subscription where S.Input == Void {
        private var subscriber: S?
        weak private var control: Control?

        init(subscriber: S, control: Control, event: Control.Event) {
            self.subscriber = subscriber
            self.control = control
            control.addTarget(self, action: #selector(handleEvent), for: event)
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
#endif
