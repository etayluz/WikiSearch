//
//  WikiAppTests.m
//  WikiAppTests
//
//  Created by Etay Luz on 1/12/15.
//  Copyright (c) 2015 com.desk.wikiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WikiViewController.h"

@interface WikiAppTests : XCTestCase
@property (nonatomic, strong) WikiViewController *wikiViewController;
@end

@implementation WikiAppTests

- (void)setUp {
    [super setUp];
    self.wikiViewController = [WikiViewController new];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.wikiViewController = nil;
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testSearch1 {

  [self.wikiViewController view];
  self.wikiViewController.searchField.text = @"Test";
  [self.wikiViewController searchButtonPressed];
 
  XCTAssertTrue(self.wikiViewController.searchResults.count > 0, @"No results found");
}

- (void)testSearch2 {
  
  [self.wikiViewController view];
  self.wikiViewController.searchField.text = @"basdflj dsalkjfsadflkj slkjf";
  [self.wikiViewController searchButtonPressed];
  
  XCTAssertTrue(self.wikiViewController.searchResults.count == 0, @"Found a result, but wasn't supposed to");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
