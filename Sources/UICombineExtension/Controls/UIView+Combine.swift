import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UIView {
    var isOpaque: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isOpaque = $1 }
    }

    var isHidden: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isHidden = $1 }
    }

    /// Bindable sink for `alpha` property.
    var alpha: BindingSink<Base, CGFloat> {
        return BindingSink(owner: base) { view, alpha in
            view.alpha = alpha
        }
    }

    /// Bindable sink for `backgroundColor` property.
    var backgroundColor: BindingSink<Base, UIColor?> {
        return BindingSink(owner: base) { view, color in
            view.backgroundColor = color
        }
    }

    /// Bindable sink for `isUserInteractionEnabled` property.
    var isUserInteractionEnabled: BindingSink<Base, Bool> {
        return BindingSink(owner: base) { view, userInteractionEnabled in
            view.isUserInteractionEnabled = userInteractionEnabled
        }
    }
}
#endif
