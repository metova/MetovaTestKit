//
//  MTKConstraintTester.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 7/29/16.
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
 Synchronously tests the provided block for broken constraints. If any constraints are broken, the test fails. Otherwise, it passes.
 
 - parameter message:   The message to log upon test failure.
 - parameter file:      The file the test is called from.
 - parameter line:      The line number the test is called from.
 - parameter testBlock: The block to test.
 
 - returns: Number of broken constraints during test
 */
@discardableResult public func MTKAssertNoBrokenConstraints(message: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line, testBlock: () -> Void) -> UInt {
    
    let brokenConstraintCount = MTKCountBrokenConstraints(testBlock)
    let message = message() ?? "Found \(brokenConstraintCount) broken constraints while executing test block."
    
    XCTAssertEqual(0, brokenConstraintCount, message, file: file, line: line)
    
    return brokenConstraintCount
}
