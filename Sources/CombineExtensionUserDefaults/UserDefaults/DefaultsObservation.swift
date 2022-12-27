//
//  File.swift
//  CombineExtension
//
//  Created by Amine Bensalah on 05/07/2020.
//

import Foundation
import Combine
import CombineExtension

final class DefaultsObservation<T: PropertyListValue>: NSObject, Cancellable {
    let key: UserDefaultsKey
    var isDisposed: Bool = false
    var userDefaults: UserDefaults
    private var onChange: (T?) -> Void

    init(key: UserDefaultsKey, userDefaults: UserDefaults = .standard, onChange: @escaping (T?) -> Void) {
        self.key = key
        self.onChange = onChange
        self.userDefaults = userDefaults
        super.init()
        self.userDefaults.addObserver(self, forKeyPath: key.rawValue, options: [.new], context: nil)
    }

    // swiftlint:disable block_based_kvo
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
        guard let change = change, object != nil, keyPath == key.rawValue else { return }
        onChange(change[.newKey] as? T)
    }

    // swiftlint:enable block_based_kvo

    func cancel() {
        if !isDisposed {
            userDefaults.removeObserver(self, forKeyPath: key.rawValue, context: nil)
            isDisposed = true
        }
    }
}
