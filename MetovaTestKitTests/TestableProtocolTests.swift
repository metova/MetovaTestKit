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
        
        let expectation = self.expectation(description: "Block executed")
        
        TestableViewController.test { testVC in
            defer { expectation.fulfill() }
            
            XCTAssertNotNil(testVC.view)
            XCTAssertNotNil(testVC.testLabel)
            XCTAssertNotNil(testVC.testButton)
        }
        
        waitForExpectations(timeout: 0, handler: nil)
    }
    
    func testDidCallViewDidLoad() {
        
        let expectation = self.expectation(description: "Block executed")
        
        TestableViewController.test { testVC in
            defer { expectation.fulfill() }
            
            XCTAssertEqual(testVC.testLabel.text, TestableViewController.TestLabelString)
            XCTAssertEqual(testVC.testButton.currentTitle, TestableViewController.TestButtonString)
        }
        
        waitForExpectations(timeout: 0, handler: nil)
    }
}
