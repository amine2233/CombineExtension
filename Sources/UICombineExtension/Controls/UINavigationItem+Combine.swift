#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension CombineExtension where Base: UINavigationItem {
    /// Bindable sink for `enabled` property.
    var title: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.title = $1 }
    }

    var hidesBackButton: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.hidesBackButton = $1 }
    }
}

#endif
