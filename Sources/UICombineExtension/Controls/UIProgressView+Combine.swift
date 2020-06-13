#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension CombineExtension where Base: UIProgressView {
    public var progress: BindingSink<Base, Float> {
        BindingSink(owner: base) { $0.progress = $1 }
    }
}
#endif
