import Foundation

#if canImport(Combine)
import Combine

extension Publisher where Output: Sequence {
	typealias Sorter = (Output.Element, Output.Element) -> Bool

	func sort(by sorter: @escaping Sorter) -> Publishers.Map<Self, [Output.Element]> {
		map { sequence in
			sequence.sorted(by: sorter)
		}
	}
}

#endif
