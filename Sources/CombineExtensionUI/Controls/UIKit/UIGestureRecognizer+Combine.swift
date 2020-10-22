//
//  UIGestureRecognizer+Combine.swift
//  Pods
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

// MARK: - Gesture Publishers
public extension CombineExtension where Base: UITapGestureRecognizer {
    /// A publisher which emits when this Tap Gesture Recognizer is triggered
    var tap: AnyPublisher<UITapGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

public extension CombineExtension where Base: UIPinchGestureRecognizer {
    /// A publisher which emits when this Pinch Gesture Recognizer is triggered
    var pinch: AnyPublisher<UIPinchGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

public extension CombineExtension where Base: UIRotationGestureRecognizer {
    /// A publisher which emits when this Rotation Gesture Recognizer is triggered
    var rotation: AnyPublisher<UIRotationGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

public extension CombineExtension where Base: UISwipeGestureRecognizer {
    /// A publisher which emits when this Swipe Gesture Recognizer is triggered
    var swipe: AnyPublisher<UISwipeGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

public extension CombineExtension where Base: UIPanGestureRecognizer {
    /// A publisher which emits when this Pan Gesture Recognizer is triggered
    var pan: AnyPublisher<UIPanGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

public extension CombineExtension where Base: UIScreenEdgePanGestureRecognizer {
    /// A publisher which emits when this Screen Edge Gesture Recognizer is triggered
    var screenEdgePan: AnyPublisher<UIScreenEdgePanGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

public extension CombineExtension where Base: UILongPressGestureRecognizer {
    /// A publisher which emits when this Long Press Recognizer is triggered
    var longPress: AnyPublisher<UILongPressGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

// MARK: - Private Helpers
// A private generic helper function which returns the provided
// generic publisher whenever its specific event occurs.
private func gesturePublisher<Gesture: UIGestureRecognizer>(for gesture: Gesture) -> AnyPublisher<Gesture, Never> {
    Publishers.ControlTarget(control: gesture,
                             addTargetAction: { gesture, target, action in
                                gesture.addTarget(target, action: action)
                             },
                             removeTargetAction: { gesture, target, action in
                                gesture?.removeTarget(target, action: action)
                             })
              .map { gesture }
              .eraseToAnyPublisher()
}
#endif
