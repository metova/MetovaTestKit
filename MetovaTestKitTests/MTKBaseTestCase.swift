//
//  BaseTestCase.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 7/30/16.
//  Copyright © 2016 Metova. All rights reserved.
//

/*
 
 This base test class allows us to verify that the various assertions we're creating through MTK actually throw failures.  The current implementation just allows one failed test per `expectTestFailure` block.  We can potentially modify this in the future, but I think for now, the expectation should be that tests are written expecting just one failure.  Any assertion failures after the first will fail as normal.
 
 The idea for this implementation came from an answer received on this Stack Overflow question: http://stackoverflow.com/q/38675192/2792531
 
 */

import XCTest

struct TestFailureExpectation {
    
    let message: String?
    let description: String?
    let filePath: String?
    let lineNumber: UInt?
    
    init(message: String? = nil, description: String? = nil, filePath: String? = nil, lineNumber: UInt? = nil) {
        self.message = message
        self.description = description
        self.filePath = filePath
        self.lineNumber = lineNumber
    }
    
}

class MTKBaseTestCase: XCTestCase {

    private var expectingFailure: TestFailureExpectation?
    
    override func recordFailureWithDescription(description: String, inFile filePath: String, atLine lineNumber: UInt, expected: Bool) {
        
        if let expectedFailure = expectingFailure where expected
            && (expectedFailure.message == nil || description.hasSuffix(expectedFailure.message ?? ""))
            && (expectedFailure.description == nil || description == expectedFailure.description)
            && (expectedFailure.filePath == nil || expectedFailure.filePath == filePath)
            && (expectedFailure.lineNumber == nil || expectedFailure.lineNumber == lineNumber) {
            
            expectingFailure = nil
        }
        else {
            super.recordFailureWithDescription(description, inFile: filePath, atLine: lineNumber, expected: expected)
        }
    }
    
    func expectTestFailure(failure: TestFailureExpectation = TestFailureExpectation(), @autoclosure message: () -> String? = nil, file: StaticString = #file, line: UInt = #line, @noescape inBlock testBlock: () -> Void) {
        expectingFailure = failure
        testBlock()
        
        if expectingFailure != nil {
            expectingFailure = nil
            let message = message() ?? "Failed to catch test failure in block."
            XCTFail(message, file: file, line: line)
        }
        
    }
    
}
