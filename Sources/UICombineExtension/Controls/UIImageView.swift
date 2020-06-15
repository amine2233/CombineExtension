#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension CombineExtension where Base: UIImageView {
    var image: BindingSink<Base, UIImage?> {
        BindingSink(owner: base) { $0.image = $1 }
    }

    var data: BindingSink<Base, Data> {
        BindingSink(owner: base) { $0.image = UIImage(data: $1) }
    }
}

#endif
