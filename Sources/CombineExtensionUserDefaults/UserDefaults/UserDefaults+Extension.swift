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
    public func change<T: PropertyListValue>(key: UserDefaultsKey) -> AnyPublisher<T?, Never> {
        Publishers.DefaultsObservation(userDefaults: base, key: key)
            .eraseToAnyPublisher()
    }

    public func onChange<T:PropertyListValue>(key: UserDefaultsKey, callback: @escaping (T?) -> Void) -> AnyCancellable {
        DefaultsObservation(key: key, userDefaults: base, onChange: callback)
            .eraseToAnyCancellable()
    }
}
