import Combine
import CombineExtension
#if os(macOS)
import Cocoa

public extension CombineExtension where Base: NSSlider {

    /// Reactive wrapper for control event.
    var value: AnyPublisher<Double, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.doubleValue)
                  .eraseToAnyPublisher()
    }

    var doubleValue: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.doubleValue = $1 }
    }

    var minValue: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.minValue = $1 }
    }

    var maxValue: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.maxValue = $1 }
    }
}
#endif
