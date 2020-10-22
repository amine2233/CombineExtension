//
//  UIStepper+Combine.swift
//  Pods
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UIStepper {
    /// A publisher emitting value changes for this stepper.
    var value: AnyPublisher<Double, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.value)
                  .eraseToAnyPublisher()
    }

    /// Reactive wrapper for `stepValue` property.
    var stepValue: BindingSink<Base, Double> {
        BindingSink(owner: base) { $0.stepValue = $1 }
    }
}
#endif
