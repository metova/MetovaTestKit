//
//  MTKConstraintTester.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 7/29/16.
//  Copyright © 2016 Metova. All rights reserved.
//

import XCTest

/**
  Synchronously tests the provided block for broken constraints.  If any constraints are broken, the test fails.  Otherwise, it passes.
 
 - parameter message:   The message to log upon test failure.
 - parameter file:      The file the test is called from.
 - parameter line:      The line number the test is called from.
 - parameter testBlock: The block to test.
 
 - returns: Number of broken constraints during test
 */
public func MTKAssertNoBrokenConstraints(message: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line, testBlock: () -> Void) -> UInt {
    
    let brokenConstraintCount = MTKCountBrokenConstraints(testBlock)
    let message = message() ?? "Found \(brokenConstraintCount) broken constraints while executing test block."
    
    XCTAssertEqual(0, brokenConstraintCount, message, file: file, line: line)
    
    return brokenConstraintCount
}
