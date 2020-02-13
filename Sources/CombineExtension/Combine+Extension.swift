import Foundation

public struct CombineExtension<Base> {
    public let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

public protocol CombineCompatible {
    associatedtype CombineExtensionBase

    static var combine: CombineExtension<CombineExtensionBase>.Type { get set }
    var combine: CombineExtension<CombineExtensionBase> { get set }
}

extension CombineCompatible {

    public static var combine: CombineExtension<Self>.Type {
        return CombineExtension<Self>.self
    }

    public var combine: CombineExtension<Self> {
        return CombineExtension<Self>(self)
    }
}

