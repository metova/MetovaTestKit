//
//  ExceptionTestingTests.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 5/7/16.
//  Copyright © 2016 Metova. All rights reserved.
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
        
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 87)) {
            
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
        
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 114)) {
            
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

        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 193)) {
            
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
        
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 221)) {
            
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
