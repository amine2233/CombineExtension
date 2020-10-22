import Combine
import CombineExtension
#if os(macOS)
import Cocoa

public extension CombineExtension where Base: NSTextView {

    var change: AnyPublisher<String?, Never> {
        Publishers
            .CombineControlNotification(notification: .default, name: NSText.didChangeNotification, object: base)
            .compactMap { ($0.object as? Base)?.string }
            .eraseToAnyPublisher()
    }

    var endEditing: AnyPublisher<String?, Never> {
        Publishers
            .CombineControlNotification(notification: .default, name: NSText.didEndEditingNotification, object: base)
            .compactMap { ($0.object as? Base)?.string }
            .eraseToAnyPublisher()
    }

    var beginEditing: AnyPublisher<String?, Never> {
        Publishers
            .CombineControlNotification(notification: .default, name: NSText.didBeginEditingNotification, object: base)
            .compactMap { ($0.object as? Base)?.string }
            .eraseToAnyPublisher()
    }

    var frame: AnyPublisher<NSRect?, Never> {
        Publishers
            .CombineControlNotification(notification: .default, name: NSText.frameDidChangeNotification, object: base)
            .compactMap { ($0.object as? Base)?.frame }
            .eraseToAnyPublisher()
    }

    var bounds: AnyPublisher<NSRect?, Never> {
        Publishers
            .CombineControlNotification(notification: .default, name: NSText.boundsDidChangeNotification, object: base)
            .compactMap { ($0.object as? Base)?.bounds }
            .eraseToAnyPublisher()
    }

    var string: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.string = $1 ?? "" }
    }
}
#endif
