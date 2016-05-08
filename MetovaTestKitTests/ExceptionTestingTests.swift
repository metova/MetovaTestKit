//
//  ExceptionTestingTests.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 5/7/16.
//  Copyright © 2016 Metova. All rights reserved.
//

import XCTest

@testable import MetovaTestKit

class ExceptionTestingTests: XCTestCase {

    func testCatchExceptionReturnsNil() {
        
        var didReachEnd: Bool?
        
        let exception = MTKCatchException {
            didReachEnd = false
            
            didReachEnd = true
        }

        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertTrue(endReached)
        
        XCTAssertNil(exception)
    }
    
    func testCatchExceptionCatchesCorrectException() {
        
        var didReachEnd: Bool?
        
        let exception = MTKCatchException {
            didReachEnd = false
            
            let arr = NSArray()
            arr.objectAtIndex(3)
            
            didReachEnd = true
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertFalse(endReached)
        
        XCTAssertNotNil(exception)
    }
    
    func testAssertNoExceptionPasses() {
        
        var didReachEnd: Bool?
        
        MTKAssertNoException(message: "TEST MESSAGE") {
            didReachEnd = false

            didReachEnd = true
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertTrue(endReached)
    }
    
    func testAssertNoExceptionDefaultMessagePasses() {
        
        var didReachEnd: Bool?
        
        MTKAssertNoException {
            didReachEnd = false
            
            didReachEnd = true
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertTrue(endReached)
    }
    
    func testAssertNoExceptionFails() {
        // TODO: Find a way to verify that MTKAssertNoException fails.  I know it fails, but the only way I can get it to fail also fails *this* test itself.  How do we verify a test fails without failing the test that's testing it?
    }
    
    func testAssertNoExceptionDefaultMessageFails() {
        // TODO: Same as above method, but use default for message argument.
    }
    
    func testAssertExceptionPasses() {
        
        var didReachEnd: Bool?
        
        MTKAssertException(message: "TEST MESSAGE") {
            didReachEnd = false
            
            let arr = NSArray()
            arr.objectAtIndex(3)
            
            didReachEnd = true
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertFalse(endReached)
    }
    
    func testAssertExceptionDefaultMessagePasses() {
        
        var didReachEnd: Bool?
        
        MTKAssertException {
            didReachEnd = false
            
            let arr = NSArray()
            arr.objectAtIndex(3)
            
            didReachEnd = true
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertFalse(endReached)
    }
    
    func testAssertExceptionFails() {
        // TODO: Find a way to verify that MTKAssertException fails.  I know it fails, but the only way I can get it to fail also fails *this* test itself.  How do we verify a test fails without failing the test that's testing it?
    }
    
    func testAssertExceptionDefaultMessageFails() {
        // TODO: Same as above method, but use default for message argument.
    }
}
