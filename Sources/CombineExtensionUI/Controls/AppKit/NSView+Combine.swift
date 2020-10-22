import Combine
import CombineExtension
#if os(macOS)
import Cocoa

public extension CombineExtension where Base: NSView {

    var frame: AnyPublisher<NSRect?, Never> {
        Publishers
            .CombineControlNotification(notification: .default, name: NSView.frameDidChangeNotification, object: base)
            .compactMap { ($0.object as? Base)?.frame }
            .eraseToAnyPublisher()
    }

    var bounds: AnyPublisher<NSRect?, Never> {
        Publishers
            .CombineControlNotification(notification: .default, name: NSView.boundsDidChangeNotification, object: base)
            .compactMap { ($0.object as? Base)?.bounds }
            .eraseToAnyPublisher()
    }

    var alpha: BindingSink<Base, CGFloat> {
        BindingSink(owner: base) { $0.alphaValue = $1 }
    }

    var isHidden: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isHidden = $1 }
    }
}
#endif
