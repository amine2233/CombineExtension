#if canImport(UIKit) && !os(watchOS)
import CombineExtension
import Combine
import UIKit

extension Publishers {
    struct SearchBarText: Publisher {
        typealias Output = String
        typealias Failure = Never

        private let searchBar: UISearchBar

        init(searchBar: UISearchBar) {
            self.searchBar = searchBar
        }

        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SubscriptionSearchBar(subscriber: subscriber, searchBar: searchBar)
            subscriber.receive(subscription: subscription)
        }
    }

    struct SearchBarCancel: Publisher {
        typealias Output = Void
        typealias Failure = Never

        private let searchBar: UISearchBar

        init(searchBar: UISearchBar) {
            self.searchBar = searchBar
        }

        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SubscriptionSearchBarCancel(subscriber: subscriber, searchBar: searchBar)
            subscriber.receive(subscription: subscription)
        }
    }

    struct SearchBarBookmarks: Publisher {
        typealias Output = Void
        typealias Failure = Never

        private let searchBar: UISearchBar

        init(searchBar: UISearchBar) {
            self.searchBar = searchBar
        }

        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SubscriptionSearchBarBookmarks(subscriber: subscriber, searchBar: searchBar)
            subscriber.receive(subscription: subscription)
        }
    }

    struct SearchBarClicked: Publisher {
        typealias Output = Void
        typealias Failure = Never

        private let searchBar: UISearchBar

        init(searchBar: UISearchBar) {
            self.searchBar = searchBar
        }

        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SubscriptionSearchBarClicked(subscriber: subscriber, searchBar: searchBar)
            subscriber.receive(subscription: subscription)
        }
    }

    struct SearchBarShouldBeginEditing<Control: UISearchBar>: Publisher {
        typealias Output = Void
        typealias Failure = Never

        private let searchBar: Control
        private let completion: (Control) -> Bool

        init(searchBar: Control, completion: @escaping (Control) -> Bool) {
            self.searchBar = searchBar
            self.completion = completion
        }

        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SubscriptionSearchBarShouldBeginEditing(subscriber: subscriber, searchBar: searchBar, completion: completion)
            subscriber.receive(subscription: subscription)
        }
    }

    struct SearchBarTextDidBeginEditing: Publisher {
        typealias Output = Void
        typealias Failure = Never

        private let searchBar: UISearchBar

        init(searchBar: UISearchBar) {
            self.searchBar = searchBar
        }

        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SubscriptionSearchBarTextDidBeginEditing(subscriber: subscriber, searchBar: searchBar)
            subscriber.receive(subscription: subscription)
        }
    }

    struct SearchBarTextDidEndEditing: Publisher {
        typealias Output = Void
        typealias Failure = Never

        private let searchBar: UISearchBar

        init(searchBar: UISearchBar) {
            self.searchBar = searchBar
        }

        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SubscriptionSearchBarTextDidEndEditing(subscriber: subscriber, searchBar: searchBar)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension Publishers.SearchBarText {
    private final class SubscriptionSearchBar<S: Subscriber>: NSObject, Subscription, UISearchBarDelegate where S.Input == String {

        private var subscriber: S?
        private let searchBar: UISearchBar

        init(subscriber: S, searchBar: UISearchBar) {
            self.subscriber = subscriber
            self.searchBar = searchBar
            super.init()
            self.searchBar.delegate = self
        }

        func request(_ demand: Subscribers.Demand) {

        }

        func cancel() {
            subscriber = nil
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            _ = subscriber?.receive(searchText)
        }
    }
}

extension Publishers.SearchBarCancel {
    private final class SubscriptionSearchBarCancel<S: Subscriber>: NSObject, Subscription, UISearchBarDelegate where S.Input == Void {

        private var subscriber: S?
        private let searchBar: UISearchBar

        init(subscriber: S, searchBar: UISearchBar) {
            self.subscriber = subscriber
            self.searchBar = searchBar
            super.init()
            self.searchBar.delegate = self
        }

        func request(_ demand: Subscribers.Demand) {

        }

        func cancel() {
            subscriber = nil
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            _ = subscriber?.receive(())
        }
    }
}

extension Publishers.SearchBarBookmarks {
    private final class SubscriptionSearchBarBookmarks<S: Subscriber>: NSObject, Subscription, UISearchBarDelegate where S.Input == Void {

        private var subscriber: S?
        private let searchBar: UISearchBar

        init(subscriber: S, searchBar: UISearchBar) {
            self.subscriber = subscriber
            self.searchBar = searchBar
            super.init()
            self.searchBar.delegate = self
        }

        func request(_ demand: Subscribers.Demand) {

        }

        func cancel() {
            subscriber = nil
        }

        func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
            _ = subscriber?.receive(())
        }
    }
}

extension Publishers.SearchBarClicked {
    private final class SubscriptionSearchBarClicked<S: Subscriber>: NSObject, Subscription, UISearchBarDelegate where S.Input == Void {

        private var subscriber: S?
        private let searchBar: UISearchBar

        init(subscriber: S, searchBar: UISearchBar) {
            self.subscriber = subscriber
            self.searchBar = searchBar
            super.init()
            self.searchBar.delegate = self
        }

        func request(_ demand: Subscribers.Demand) {

        }

        func cancel() {
            subscriber = nil
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            _ = subscriber?.receive(())
        }
    }
}

extension Publishers.SearchBarShouldBeginEditing {
    private final class SubscriptionSearchBarShouldBeginEditing<S: Subscriber, Control: UISearchBar>: NSObject, Subscription, UISearchBarDelegate where S.Input == Void {

        private var subscriber: S?
        private let searchBar: Control
        private let completion: (Control) -> Bool

        init(subscriber: S, searchBar: Control, completion: @escaping (Control) -> Bool) {
            self.subscriber = subscriber
            self.searchBar = searchBar
            self.completion = completion
            super.init()
            self.searchBar.delegate = self
        }

        func request(_ demand: Subscribers.Demand) {

        }

        func cancel() {
            subscriber = nil
        }

        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            _ = subscriber?.receive(())
            return completion(searchBar as! Control)
        }
    }
}

extension Publishers.SearchBarTextDidBeginEditing {
    private final class SubscriptionSearchBarTextDidBeginEditing<S: Subscriber>: NSObject, Subscription, UISearchBarDelegate where S.Input == Void {

        private var subscriber: S?
        private let searchBar: UISearchBar

        init(subscriber: S, searchBar: UISearchBar) {
            self.subscriber = subscriber
            self.searchBar = searchBar
            super.init()
            self.searchBar.delegate = self
        }

        func request(_ demand: Subscribers.Demand) {

        }

        func cancel() {
            subscriber = nil
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            _ = subscriber?.receive(())
        }
    }
}

extension Publishers.SearchBarTextDidEndEditing {
    private final class SubscriptionSearchBarTextDidEndEditing<S: Subscriber>: NSObject, Subscription, UISearchBarDelegate where S.Input == Void {

        private var subscriber: S?
        private let searchBar: UISearchBar

        init(subscriber: S, searchBar: UISearchBar) {
            self.subscriber = subscriber
            self.searchBar = searchBar
            super.init()
            self.searchBar.delegate = self
        }

        func request(_ demand: Subscribers.Demand) {

        }

        func cancel() {
            subscriber = nil
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            _ = subscriber?.receive(())
        }
    }
}


extension CombineExtension where Base: UISearchBar {
    public var value: AnyPublisher<String, Never> {
        Publishers.SearchBarText(searchBar: base)
            .eraseToAnyPublisher()
    }

    public var clicked: AnyPublisher<Void, Never> {
        Publishers.SearchBarClicked(searchBar: base)
            .eraseToAnyPublisher()
    }

    public var cancel: AnyPublisher<Void, Never> {
        Publishers.SearchBarCancel(searchBar: base)
            .eraseToAnyPublisher()
    }

    public var bookarks: AnyPublisher<Void, Never> {
        Publishers.SearchBarBookmarks(searchBar: base)
            .eraseToAnyPublisher()
    }

    public var textDidBeginEditing: AnyPublisher<Void, Never> {
        Publishers.SearchBarTextDidBeginEditing(searchBar: base)
            .eraseToAnyPublisher()
    }

    public var textDidEndEditing: AnyPublisher<Void, Never> {
        Publishers.SearchBarTextDidEndEditing(searchBar: base)
            .eraseToAnyPublisher()
    }

    public func shouldBeginEditing(completion: @escaping (Base) -> Bool) -> AnyPublisher<Void, Never> {
        Publishers.SearchBarShouldBeginEditing(searchBar: base, completion: completion)
            .eraseToAnyPublisher()
    }

    public var text: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.text = $1 }
    }

    public var placeholder: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.placeholder = $1 }
    }
}
#endif
