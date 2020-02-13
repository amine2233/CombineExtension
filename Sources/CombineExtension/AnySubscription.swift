import Foundation

#if canImport(Combine)
import Combine

public final class AnySubscription: Subscription {
    private let cancellable: Cancellable

    public init(cancellable: Cancellable) {
        self.cancellable = cancellable
    }

    public init(_ cancel: @escaping () -> Void) {
        self.cancellable = AnyCancellable(cancel)
    }

    public func request(_ demand: Subscribers.Demand) {}

    public func cancel() {
        self.cancellable.cancel()
    }
}
#endif
