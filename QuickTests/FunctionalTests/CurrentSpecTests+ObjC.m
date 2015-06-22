#import <XCTest/XCTest.h>
#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "QCKSpecRunner.h"

QuickSpecBegin(FunctionalTests_CurrentSpec)

it(@"returns the correct instance", ^{
    expect(@(sel_getName([QuickSpec current].invocation.selector)))
        .to(equal(@"returns_the_correct_instance"));
});

it(@"handles expectations", ^{
    XCTestExpectation *expectation = [QuickSpec.current expectationWithDescription:@"simple expectation"];
    [expectation fulfill];
    [QuickSpec.current waitForExpectationsWithTimeout:0.1 handler:nil];
});

QuickSpecEnd

@interface CurrentSpecTests : XCTestCase; @end

@implementation CurrentSpecTests

- (void)testAllExamplesAreExecuted {
    XCTestRun *result = qck_runSpec([FunctionalTests_CurrentSpec class]);
    XCTAssertEqual(result.executionCount, 2);
}

@end
