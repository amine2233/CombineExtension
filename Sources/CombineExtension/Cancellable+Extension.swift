import Foundation

extension NSRecursiveLock {

    public convenience init(name: String?) {
        self.init()
        self.name = name
    }
}

#if canImport(Combine)
import Combine

public struct NonCancellable: Cancellable {

    public static let instance = NonCancellable()

    private init() {}

    public func cancel() {}
}

public final class BlockCancellable: Cancellable {

    private var handler: (() -> Void)
    private let lock = NSRecursiveLock(name: "com.recursiveLock.blockcancelable")

    public init(_ handler: @escaping (() -> Void)) {
        self.handler = handler
    }

    public func cancel() {
        lock.lock(); defer { lock.unlock() }
        handler()
    }
}

public final class DeinitDisposable: Cancellable {

    private let otherCancellable: Cancellable

    public init(cancellable: Cancellable) {
        otherCancellable = cancellable
    }

    public func cancel() {
        otherCancellable.cancel()
    }

    deinit {
        cancel()
    }
}

public final class CompositeCancellable: Cancellable {

    private var cancellables: [Cancellable] = []
    private let lock = NSRecursiveLock(name: "com.recursiveLock.blockcancellable")

    public convenience init() {
        self.init([])
    }

    public init(_ cancellables: [Cancellable]) {
        self.cancellables = cancellables
    }

    public func add(cancellable: Cancellable) {
        lock.lock(); defer { lock.unlock() }
        cancellables.append(cancellable)
    }

    public func add(completion: @escaping () -> Cancellable) {
        add(cancellable: completion())
    }

    public static func += (left: CompositeCancellable, right: Cancellable) {
        left.add(cancellable: right)
    }

    public func cancel() {
        lock.lock(); defer { lock.unlock() }
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

extension Cancellable {

    public func cancel(in cancelContainer: CancellableContainer) {
        cancelContainer.add(cancellable: self)
    }
}

/// When bag gets deallocated, it will dispose all disposables it contains.
public protocol CacellableContainerProtocol: Cancellable {
    func add(cancellable: Cancellable)
}

public final class CancellableContainer: CacellableContainerProtocol {

    private var cancellables: [Cancellable] = []
    private let lock = NSRecursiveLock(name: "com.recursiveLock.blockcontainercancellable")

    public init() {}

    /// Add the given cancellable to the bag.
    /// `Cancellable` will be disposed when the bag is deallocated.
    public func add(cancellable: Cancellable) {
        cancellables.append(cancellable)
    }

    /// Add the given cancellables to the bag.
    /// ``Cancellable` will be disposed when the bag is deallocated.
    public func add(cancellable: [Cancellable]) {
        cancellables.forEach(add)
    }

    /// Add a cancellable to a cancellable bag.
    public static func += (left: CancellableContainer, right: Cancellable) {
        left.add(cancellable: right)
    }

    /// Add multiple cancellables to a cancellable bag.
    public static func += (left: CancellableContainer, right: [Cancellable]) {
        left.add(cancellable: right)
    }

    /// Cancel all cancellables that are currenty in the bag.
    public func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    deinit {
        cancel()
    }
}

protocol CancellableContainerProvider {
    var cancellable: CancellableContainer { get }
}

extension NSObject: CancellableContainerProvider {

    private struct AssociatedKeys {
        static var DisposableKey = "CancellableBagKey"
    }

    public var cancellable: CancellableContainer {
        if let cancelBag = objc_getAssociatedObject(self, &NSObject.AssociatedKeys.DisposableKey) {
            return cancelBag as! CancellableContainer
        } else {
            let cancelBag = CancellableContainer()
            objc_setAssociatedObject(
                self,
                &NSObject.AssociatedKeys.DisposableKey,
                cancelBag,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            return cancelBag
        }
    }
}

extension Cancellable {
    public func eraseToAnyCancellable() -> AnyCancellable {
        AnyCancellable(self)
    }
}

#endif
