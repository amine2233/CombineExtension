//
//  UserDefaults+Extension.swift
//  CombineExtension
//
//  Created by Amine Bensalah on 05/07/2020.
//

import Foundation
import Combine
import CombineExtension

extension CombineExtension where Base: UserDefaults {
    public func change<T: PropertyListValue>(key: Key) -> AnyPublisher<T?, Never> {
        Publishers.DefaultsObservation(userDefaults: base, key: key)
            .eraseToAnyPublisher()
    }

    public func onChange<T:PropertyListValue>(key: Key, callback: @escaping (T?) -> Void) -> AnyCancellable {
        DefaultsObservation(key: key, userDefaults: base, onChange: callback)
            .configure()
            .eraseToAnyCancellable()
    }
}
