import Combine
import CombineExtension
#if os(macOS)
import Cocoa

public extension CombineExtension where Base: NSTextField {

    var placeholderString: BindingSink<Base, String?> {
        BindingSink(owner: base) { $0.placeholderString = $1 ?? "" }
    }

    var backgroundColor: BindingSink<Base, NSColor> {
        BindingSink(owner: base) { $0.backgroundColor = $1 }
    }

    var attributedStringValue: BindingSink<Base, NSAttributedString> {
        BindingSink(owner: base) { $0.attributedStringValue = $1 }
    }

    var isBordered: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isBordered = $1 }
    }

    var isSelectable: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isSelectable = $1 }
    }

    var isEditable: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isEditable = $1 }
    }

    var isBezeled: BindingSink<Base, Bool> {
        BindingSink(owner: base) { $0.isBezeled = $1 }
    }
}
#endif
