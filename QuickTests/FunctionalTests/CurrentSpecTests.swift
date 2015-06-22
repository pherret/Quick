import XCTest
import Quick
import Nimble

class FunctionalTests_CurrentSpec: QuickSpec {
    override func spec() {
        it("returns the correct instance") {
            expect(QuickSpec.current().invocation?.selector)
                .to(equal(Selector("returns_the_correct_instance")))
        }
        
        it("handles expectations") {
            let expectation = QuickSpec.current().expectationWithDescription("simple expectation")
            expectation.fulfill()
            QuickSpec.current().waitForExpectationsWithTimeout(0.1, handler: nil)
        }
    }
}

class CurrentSpecTests: XCTestCase {
    func testExecuteExamples() {
        let result = qck_runSpec(FunctionalTests_CurrentSpec.classForCoder())
        XCTAssertEqual(result.executionCount, 2 as UInt)
    }
    
    func testCurrentRaisesExceptionOutsideOfExample() {
        expect { QuickSpec.current() }
            .to(raiseException(named: "NSInternalInconsistencyException"))
    }
}
