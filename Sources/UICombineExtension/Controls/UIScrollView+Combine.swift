//
//  UIScrollView+Combine.swift
//  Pods
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import CombineExtension
#if canImport(UIKit)
import UIKit

public extension CombineExtension where Base: UIScrollView {
    /// A publisher emitting content offset changes from this UIScrollView.
    var contentOffsetPublisher: AnyPublisher<CGPoint, Never> {
        base.publisher(for: \.contentOffset)
            .eraseToAnyPublisher()
    }

    /// A publisher emitting if the bottom of the UIScrollView is reached.
    ///
    /// - parameter offset: A threshold indicating how close to the bottom of the UIScrollView this publisher should emit.
    ///                     Defaults to 0
    /// - returns: A publisher that emits when the bottom of the UIScrollView is reached within the provided threshold.
    func reachedBottomPublisher(offset: CGFloat = 0) -> AnyPublisher<Void, Never> {
        contentOffsetPublisher
            .map { [weak base] contentOffset -> Bool in
                guard let base = base else { return false }
                let visibleHeight = base.frame.height - base.contentInset.top - base.contentInset.bottom
                let y = contentOffset.y + base.contentInset.top
                let threshold = max(offset, base.contentSize.height - visibleHeight)
                return y > threshold
            }
            .removeDuplicates()
            .filter { $0 }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
#endif
