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
}
#endif
