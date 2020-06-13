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
    var currentPage: AnyPublisher<Int, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.currentPage)
                  .eraseToAnyPublisher()
    }
}
#endif
