import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

@available(iOS 13.4, *)
public extension CombineExtension where Base: UIButton {
    var isPointerInteractionEnabled: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isPointerInteractionEnabled = $1 }
    }
}

public extension CombineExtension where Base: UIButton {
    /// Reactive wrapper for `setTitle(_:for:)`
    func title(for controlState: UIControl.State = []) -> BindingSink<Base, String?> {
        return BindingSink(owner: base) { button, title -> Void in
            button.setTitle(title, for: controlState)
        }
    }

    /// Reactive wrapper for `setImage(_:for:)`
    func image(for controlState: UIControl.State = []) -> BindingSink<Base, UIImage?> {
        return BindingSink(owner: base) { button, image -> Void in
            button.setImage(image, for: controlState)
        }
    }

    /// Reactive wrapper for `setBackgroundImage(_:for:)`
    func backgroundImage(for controlState: UIControl.State = []) -> BindingSink<Base, UIImage?> {
        return BindingSink(owner: base) { button, image -> Void in
            button.setBackgroundImage(image, for: controlState)
        }
    }

    /// Reactive wrapper for `setAttributedTitle(_:controlState:)`
    func attributedTitle(for controlState: UIControl.State = []) -> BindingSink<Base, NSAttributedString?> {
        return BindingSink(owner: base) { button, attributedTitle -> Void in
            button.setAttributedTitle(attributedTitle, for: controlState)
        }
    }
}

#endif
