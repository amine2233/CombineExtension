//
//  UIDatePicker+Combine.swift
//  Pods
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UIDatePicker {
    /// A publisher emitting date changes from this date picker.
    var value: AnyPublisher<Date, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.date)
                  .eraseToAnyPublisher()
    }

    /// A publisher emitting countdown duration changes from this date picker.
    var countDownDuration: AnyPublisher<TimeInterval, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.countDownDuration)
                  .eraseToAnyPublisher()
    }

    var date: BindingSink<Base, Date> {
        BindingSink(owner: base) { $0.date = $1 }
    }
}
#endif
