//
//  UIRefreshControl+Combine.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UIRefreshControl {
    /// A publisher emitting refresh status changes from this refresh control.
    var isRefreshing: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.isRefreshing)
            .eraseToAnyPublisher()
    }

    var endRefreshing: BindingSink<Base, ()> {
        BindingSink(owner: base) { $0.endRefreshing() }
    }

    var beginRefreshing: BindingSink<Base, ()> {
        BindingSink(owner: base) { $0.beginRefreshing() }
    }

    var attributedTitle: AnyPublisher<NSAttributedString?, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.attributedTitle)
            .eraseToAnyPublisher()
    }
}
#endif
