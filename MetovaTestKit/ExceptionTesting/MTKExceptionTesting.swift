//
//  ExceptionTesting.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 5/6/16.
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

/**
 Synchronously tests the provided block for exceptions. If it would throw an exception, the exception is caught and the test fails. Otherwise, the test passes.
 
 - parameter message:   The message to log upon test failure.
 - parameter file:      The file the test is called from.
 - parameter line:      The line number the test is called from.
 - parameter testBlock: The block to test.
 
 - returns: The caught exception. If no exception was thrown, returns `nil`.
 
 - warning: You should not rely on `XCTestExpectation` fulfillment in this block. If an exception is thrown before fulfillment, the expectation will never be fulfilled. `XCTestExpectation` should be unnecessary as the block is executed synchronously.
 
 - warning: This will only catch Objective-C-style exceptions. Swift's `fatalError`s are not caught by this test.
 */
@discardableResult public func MTKAssertNoException(message: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line, testBlock: () -> Void) -> NSException? {
    
    let message = message() ?? "Caught exception while executing test block."
    let exception = MTKCatchException(testBlock)
    
    XCTAssertNil(exception, message, file: file, line: line)
    
    return exception
}

/**
 Synchronously tests the provided block for exceptions. If it does not throw an exception, the test fails. If it would throw an exception, the exception is caught and the test passes. Any code below the thrown exception is not executed.
 
 - parameter message:   The message to log upon test failure.
 - parameter file:      The file the test is called from.
 - parameter line:      The line number the test is called from.
 - parameter testBlock: The block to test.
 
 - returns: The caught exception. If no exception was thrown, returns `nil`.
 
 - warning: You should not rely on `XCTestExpectation` fulfillment in this block. If an exception is thrown before fulfillment, the expectation will never be fulfilled. `XCTestExpectation` should be unnecessary as the block is executed synchronously.
 
 - warning: This will only catch Objective-C-style exceptions. Swift's `fatalError`s are not caught by this test.
 */
@discardableResult public func MTKAssertException(message: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line, testBlock: () -> Void) -> NSException? {
    
    let message = message() ?? "Did not catch exception while executing test block."
    let exception = MTKCatchException(testBlock)
    
    XCTAssertNotNil(exception, message, file: file, line: line)
    
    return exception
}
