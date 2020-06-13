#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension CombineExtension where Base: UIViewController {
    @available(tvOS, unavailable)
    public var toolbarItems: BindingSink<Base, [UIBarButtonItem]?> {
        BindingSink(owner: base) { $0.toolbarItems = $1 }
    }
}
#endif
