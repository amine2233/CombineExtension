#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension CombineExtension where Base: UIApplication {
  public static var didBecomeActiveNotification: Publishers.Map<NotificationCenter.Publisher, Void> {
    NotificationCenter.default.publisher(for: Base.didBecomeActiveNotification).map { _ in }
  }
}
#endif
