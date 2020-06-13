//
//  UISegmentedControl+Combine.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UISegmentedControl {
    var value: AnyPublisher<Int, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.selectedSegmentIndex)
            .eraseToAnyPublisher()
    }

    var selectedSegmentIndex: BindingSink<Base, Int> {
        BindingSink(owner: base) { $0.selectedSegmentIndex = $1 }
    }

    /// Reactive wrapper for `setEnabled(_:forSegmentAt:)`
    func enabledForSegment(at index: Int) -> BindingSink<Base, Bool> {
        BindingSink(owner: base) { segmentedControl, segmentEnabled -> Void in
            segmentedControl.setEnabled(segmentEnabled, forSegmentAt: index)
        }
    }

    /// Reactive wrapper for `setTitle(_:forSegmentAt:)`
    func titleForSegment(at index: Int) -> BindingSink<Base, String?> {
        BindingSink(owner: base) { segmentedControl, title -> Void in
            segmentedControl.setTitle(title, forSegmentAt: index)
        }
    }

    /// Reactive wrapper for `setImage(_:forSegmentAt:)`
    func imageForSegment(at index: Int) -> BindingSink<Base, UIImage?> {
        BindingSink(owner: base) { segmentedControl, image -> Void in
            segmentedControl.setImage(image, forSegmentAt: index)
        }
    }
}
#endif
