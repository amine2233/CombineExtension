#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension CombineExtension where Base: UIActivityIndicatorView {
    var isAnimating: BindingSink<Base, Bool> {
        BindingSink(owner: base) { base, value in
            if value {
                base.startAnimating()
            } else {
                base.stopAnimating()
            }
        }
    }
}

#endif
