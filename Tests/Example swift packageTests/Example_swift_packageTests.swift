import XCTest
@testable import Example_swift_package

final class Example_swift_packageTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Example_swift_package().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
