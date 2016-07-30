//
//  TestableProtocolTests.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 5/7/16.
//  Copyright © 2016 Metova. All rights reserved.
//

import XCTest

class TestableProtocolTests: MTKBaseTestCase {
    
    func testDidCallLoadView() {
        let expectation = expectationWithDescription("Block executed")
        
        TestableViewController.test { testVC in
            defer { expectation.fulfill() }
            
            XCTAssertNotNil(testVC.view)
            XCTAssertNotNil(testVC.testLabel)
            XCTAssertNotNil(testVC.testButton)
        }
        
        waitForExpectationsWithTimeout(0, handler: nil)
    }
    
    func testDidCallViewDidLoad() {
        let expectation = expectationWithDescription("Block executed")
        
        TestableViewController.test { testVC in
            defer { expectation.fulfill() }
            
            XCTAssertEqual(testVC.testLabel.text, TestableViewController.TestLabelString)
            XCTAssertEqual(testVC.testButton.currentTitle, TestableViewController.TestButtonString)
        }
        
        waitForExpectationsWithTimeout(0, handler: nil)
    }
}
