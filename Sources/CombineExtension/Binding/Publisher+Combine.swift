//
//  Publisher+Combine.swift
//  UICombineExtension
//
//  Created by Amine Bensalah on 14/06/2020.
//

import Combine

extension Publisher {
    public func bind<B: BindingSubscriber>(to sink: B) -> AnyCancellable where B.Input == Output, B.Failure == Failure {
        B.bind(subscriber: sink, source: self)
    }

    public func bind<B: BindingSubscriber>(to sink: B) -> AnyCancellable where B.Input == Output?, B.Failure == Failure {
        B.bind(subscriber: sink, source: self)
    }
}
