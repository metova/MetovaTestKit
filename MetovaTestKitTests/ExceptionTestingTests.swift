//
//  ExceptionTestingTests.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 5/7/16.
//  Copyright © 2016 Metova. All rights reserved.
//

import XCTest

@testable import MetovaTestKit

class ExceptionTestingTests: MTKBaseTestCase {

    func testAssertNoExceptionPasses() {
        
        var didReachEnd: Bool?
        
        MTKAssertNoException(message: "TEST MESSAGE") {
            didReachEnd = false

            let arr: NSArray = [0, 1, 3, 4, 5, 6, 7, 8, 9, 10]
            arr.object(at: 3)
            
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
            
            let arr: NSArray = [0, 1, 3, 4, 5, 6, 7, 8, 9, 10]
            arr.object(at: 3)
            
            didReachEnd = true
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertTrue(endReached)
    }
    
    func testAssertNoExceptionFails() {
        
        let message = "Test Failed!"
        let description = "XCTAssertNil failed: \"*** -[__NSArray0 objectAtIndex:]: index 3 beyond bounds for empty NSArray\" - \(message)"
        
        var didReachEnd: Bool?
        
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 66)) {
            
            MTKAssertNoException(message: message) {
                didReachEnd = false
                
                let arr: NSArray = []
                arr.object(at: 3)
                
                didReachEnd = true
            }
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertFalse(endReached)
    }
    
    func testAssertNoExceptionDefaultMessageFails() {
        
        let defaultMessage = "Caught exception while executing test block."
        let description = "XCTAssertNil failed: \"*** -[__NSArray0 objectAtIndex:]: index 3 beyond bounds for empty NSArray\" - \(defaultMessage)"
        
        var didReachEnd: Bool?
        
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 94)) {
            
            MTKAssertNoException {
                didReachEnd = false
                
                let arr: NSArray = []
                arr.object(at: 3)
                
                didReachEnd = true
            }
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertFalse(endReached)
    }
    
    func testAssertNoExceptionReturnsNilWhenPassing() {
        
        let exception = MTKAssertNoException {
            let arr: NSArray = [0, 1, 3, 4, 5, 6, 7, 8, 9, 10]
            arr.object(at: 3)
        }
        
        XCTAssertNil(exception)
    }
    
    func testAssertExceptionPasses() {
        
        var didReachEnd: Bool?
        
        MTKAssertException(message: "TEST MESSAGE") {
            didReachEnd = false
            
            let arr = NSArray()
            arr.object(at: 3)
            
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
            arr.object(at: 3)
            
            didReachEnd = true
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertFalse(endReached)
    }
    
    func testAssertExceptionFails() {
        
        let message = "Test failed!"
        let description = "XCTAssertNotNil failed - \(message)"
        
        var didReachEnd: Bool?

        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 174)) {
            
            MTKAssertException(message: message) {
                
                didReachEnd = false
                
                let arr: NSArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                arr.object(at: 3)
                
                didReachEnd = true
            }
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertTrue(endReached)
    }
    
    func testAssertExceptionDefaultMessageFails() {
        
        let defaultMessage = "Did not catch exception while executing test block."
        let description = "XCTAssertNotNil failed - \(defaultMessage)"
        
        var didReachEnd: Bool?
        
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 205)) {
            
            MTKAssertException {
                
                didReachEnd = false
                
                let arr: NSArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                arr.object(at: 3)
                
                didReachEnd = true
            }
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertTrue(endReached)
    }
    
    func testAssertExceptionCatchesCorrectException() {

        let throwingBlock = {
            let arr = NSArray()
            arr.object(at: 3)
        }
        
        guard let exception = MTKAssertException(testBlock: throwingBlock) else {
            XCTFail("Failed to catch exception")
            return
        }
        
        XCTAssertEqual(exception.name, NSExceptionName.rangeException)
        XCTAssertEqual(exception.reason, "*** -[__NSArray0 objectAtIndex:]: index 3 beyond bounds for empty NSArray")
    }
}
