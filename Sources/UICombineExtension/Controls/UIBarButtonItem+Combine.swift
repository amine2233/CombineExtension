//
//  UIBarButtonItem+Combine.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Foundation
import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit.UIBarButtonItem


public extension CombineExtension where Base: UIBarButtonItem {
    var tap: AnyPublisher<Void, Never> {
        Publishers.ControlTarget(control: base,
                                 addTargetAction: { control, target, action in
                                    control.target = target
                                    control.action = action
                                 },
                                 removeTargetAction: { control, _, _ in
                                    control?.target = nil
                                    control?.action = nil
                                 })
            .eraseToAnyPublisher()
    }

    var isEnabled: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEnabled = $1 }
    }

    var title: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.title = $1 }
    }

    var image: BindingSink<Base, UIImage?> {
        BindingSink(owner: base) { $0.image = $1 }
    }
}
#endif
