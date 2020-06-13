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

#endif
