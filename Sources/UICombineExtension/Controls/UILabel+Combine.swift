#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension CombineExtension where Base: UILabel {
    public var text: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.text = $1 }
    }

    public var attributedText: BindingSink<Base, NSAttributedString?> {
        BindingSink(owner: base) { $0.attributedText = $1 }
    }
}
#endif
