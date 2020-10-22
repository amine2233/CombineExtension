//
//  UITextField+Combine.swift
//  Pods
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UITextField {
    var value: AnyPublisher<String?, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.text)
            .eraseToAnyPublisher()
    }

    var attributedValue: AnyPublisher<NSAttributedString?, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.attributedText)
            .eraseToAnyPublisher()
    }

    var didEndOnExit: AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: base,
                                events: .editingDidEndOnExit)
            .eraseToAnyPublisher()
    }

    var text: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.text = $1 }
    }

    var attributedText: BindingSink<Base, NSAttributedString?> {
        BindingSink(owner: base) { $0.attributedText = $1 }
    }

    var placeholder: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.placeholder = $1 }
    }

    var attributedPlaceholder: BindingSink<Base, NSAttributedString?> {
        BindingSink(owner: base) { $0.attributedPlaceholder = $1 }
    }

    /// Bindable sink for `isSecureTextEntry` property.
    var isSecureTextEntry: BindingSink<Base, Bool> {
        return BindingSink(owner: base) { $0.isSecureTextEntry = $1 }
    }
}
#endif
