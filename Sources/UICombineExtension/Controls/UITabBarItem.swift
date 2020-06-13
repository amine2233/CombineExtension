#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension CombineExtension where Base: UITabBarItem {
    public var badgeValue: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.badgeValue = $1 }
    }
}
#endif
