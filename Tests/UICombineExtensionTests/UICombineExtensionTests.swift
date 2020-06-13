import XCTest
import UIKit
import Combine
import CombineExtension
@testable import UICombineExtension


final class UICombineExtensionTests: XCTestCase {
    var bag = Set<AnyCancellable>()
    
    func testExample() {
        let viewModel = TestViewModel()
        let label = UILabel()

        label.combine.isHidden.bind(to: viewModel.$isHidden).store(in: &bag)

        viewModel.isHidden = true
        
        XCTAssertTrue(label.isHidden)
    }

    func testExample2() {
        let viewModel = TestViewModel()
        let label = UILabel()

        viewModel.$isHidden.bind(to: label.combine.isHidden).store(in: &bag)
        
        viewModel.isHidden = true

        XCTAssertTrue(label.isHidden)
    }

    func testExample3() {
        let viewModel = TestViewModelString()
        let label = UILabel()

        viewModel.$text.bind(to: label.combine.text).store(in: &bag)

        viewModel.text = "alors"

        XCTAssertEqual(label.text, "alors")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

private class TestViewModel: ObservableObject {
    @Published var isHidden: Bool = false
}

private class TestViewModelString: ObservableObject {
    @Published var text: String = ""
}
