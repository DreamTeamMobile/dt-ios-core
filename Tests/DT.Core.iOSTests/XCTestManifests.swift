import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DT_Core_iOSTests.allTests),
    ]
}
#endif
