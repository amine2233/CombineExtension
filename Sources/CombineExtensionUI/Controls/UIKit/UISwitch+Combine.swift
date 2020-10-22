//
//  UISwitch+Combine.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UISwitch {
    var value: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.isOn)
            .eraseToAnyPublisher()
    }

    var isOn: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isOn = $1 }
    }
}
#endif
