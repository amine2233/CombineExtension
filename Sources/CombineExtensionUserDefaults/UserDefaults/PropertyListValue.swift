//
//  PropertyListValue.swift
//  CombineExtension
//
//  Created by Amine Bensalah on 05/07/2020.
//

import Foundation
import CombineExtension

public protocol PropertyListValue {}

public struct Key: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        rawValue = value
    }
}

extension Data: PropertyListValue {}
extension NSData: PropertyListValue {}

extension String: PropertyListValue {}
extension NSString: PropertyListValue {}

extension Date: PropertyListValue {}
extension NSDate: PropertyListValue {}

extension NSNumber: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Int8: PropertyListValue {}
extension Int16: PropertyListValue {}
extension Int32: PropertyListValue {}
extension Int64: PropertyListValue {}
extension UInt: PropertyListValue {}
extension UInt8: PropertyListValue {}
extension UInt16: PropertyListValue {}
extension UInt32: PropertyListValue {}
extension UInt64: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}
#if os(macOS)
#if swift(<5.1)
extension Float80: PropertyListValue {}
#endif
#endif

extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}
