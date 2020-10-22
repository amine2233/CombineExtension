import Foundation

extension Event {
    static var defaultValueEvents: Event {
        #if os(iOS)
        return [.allEditingEvents, .valueChanged]
        #elseif os(OSX)
        return .mixed
        #endif
    }
}
