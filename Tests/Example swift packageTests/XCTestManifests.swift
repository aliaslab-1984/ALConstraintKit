import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Example_swift_packageTests.allTests),
    ]
}
#endif
