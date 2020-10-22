//
//  UIPageControl+Combine.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UIPageControl {
    /// A publisher emitting current page changes for this page control.
    var value: AnyPublisher<Int, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.currentPage)
                  .eraseToAnyPublisher()
    }

    /// Bindable sink for `currentPage` property.
    var currentPage: BindingSink<Base, Int> {
        return BindingSink(owner: base) { controller, page in
            controller.currentPage = page
        }
    }

    /// Bindable sink for `numberOfPages` property.
    var numberOfPages: BindingSink<Base, Int> {
        return BindingSink(owner: base) { controller, page in
            controller.numberOfPages = page
        }
    }
}
#endif
