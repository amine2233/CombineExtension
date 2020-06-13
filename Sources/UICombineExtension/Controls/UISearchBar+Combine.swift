#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension CombineExtension where Base: UISearchBar {
    public var text: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.text = $1 }
    }

    public var placeholder: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.placeholder = $1 }
    }
}
#endif
