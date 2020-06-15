#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension CombineExtension where Base: UIAlertAction {
    /// Bindable sink for `enabled` property.
    var isEnabled: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEnabled = $1 }
    }
}

#endif
