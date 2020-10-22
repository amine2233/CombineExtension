import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UIControl {
    var tap: AnyPublisher<Void, Never> {
        return Publishers
            .ControlEvent(control: base,
                          events: .touchUpInside)
            .eraseToAnyPublisher()
    }

    func control(events: Base.Event) -> AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: base,
                                events: events)
            .eraseToAnyPublisher()
    }

    var isEnabled: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEnabled = $1 }
    }
}
#endif
