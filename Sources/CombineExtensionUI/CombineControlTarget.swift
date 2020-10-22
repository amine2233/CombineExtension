import Combine
import Foundation

public extension Publishers {
    struct ControlTarget<Control: AnyObject>: Publisher {
        public typealias Output = Void
        public typealias Failure = Never

        private let control: Control
        private let addTargetAction: (Control, AnyObject, Selector) -> Void
        private let removeTargetAction: (Control?, AnyObject, Selector) -> Void

        public init(control: Control,
                    addTargetAction: @escaping (Control, AnyObject, Selector) -> Void,
                    removeTargetAction: @escaping (Control?, AnyObject, Selector) -> Void) {
            self.control = control
            self.addTargetAction = addTargetAction
            self.removeTargetAction = removeTargetAction
        }

        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = SubscriptionImp(subscriber: subscriber,
                                            control: control,
                                            addTargetAction: addTargetAction,
                                            removeTargetAction: removeTargetAction)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension Publishers.ControlTarget {
    private final class SubscriptionImp<S: Subscriber, Control: AnyObject>: Subscription where S.Input == Void {
        private var subscriber: S?
        weak private var control: Control?

        private let removeTargetAction: (Control?, AnyObject, Selector) -> Void
        private let action = #selector(handleAction)

        init(subscriber: S,
             control: Control,
             addTargetAction: @escaping (Control, AnyObject, Selector) -> Void,
             removeTargetAction: @escaping (Control?, AnyObject, Selector) -> Void) {
            self.subscriber = subscriber
            self.control = control
            self.removeTargetAction = removeTargetAction

            addTargetAction(control, self, action)
        }

        func request(_ demand: Subscribers.Demand) {
            // We don't care about the demand at this point.
            // As far as we're concerned - The control's target events are endless until it is deallocated.
        }

        func cancel() {
            subscriber = nil
            removeTargetAction(control, self, action)
        }

        @objc private func handleAction() {
            _ = subscriber?.receive()
        }
    }
}
