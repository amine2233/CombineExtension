//
//  UISlider+Combine.swift
//  Pods
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UISlider {
    /// A publisher emitting value changes for this slider.
    var value: AnyPublisher<Float, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.value)
                  .eraseToAnyPublisher()
    }

    /// A publisher emitting value changes for this slider.
    var slide: BindingSink<Base, Float> {
        BindingSink(owner: base) { $0.value = $1 }
    }
}
#endif
