import Combine
import CombineExtension
#if os(macOS)
import Cocoa

public extension CombineExtension where Base: NSControl {

    /// Reactive wrapper for control event.
    var tap: AnyPublisher<Void, Never> {
        return Publishers
            .ControlEvent(control: base, events: .mixed)
            .eraseToAnyPublisher()
    }

    func control(events: Base.StateValue) -> AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: base,
                                events: events)
            .eraseToAnyPublisher()
    }

    var isEnabled: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEnabled = $1 }
    }
}
#endif
