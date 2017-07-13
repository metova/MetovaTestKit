//
//  BaseTestCase.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 7/30/16.
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

/*
 
 This base test class allows us to verify that the various assertions we're creating through MTK actually throw failures. The current implementation just allows one failed test per `expectTestFailure` block. We can potentially modify this in the future, but I think for now, the expectation should be that tests are written expecting just one failure. Any assertion failures after the first will fail as normal.
 
 The idea for this implementation came from an answer received on this Stack Overflow question: http://stackoverflow.com/q/38675192/2792531
 
 */

import XCTest

struct TestFailureExpectation {
    
    let description: String?
    let filePath: String?
    let lineNumber: UInt?
    
    init(description: String? = nil, filePath: String? = nil, lineNumber: UInt? = nil) {
        self.description = description
        self.filePath = filePath
        self.lineNumber = lineNumber
    }
}

class MTKBaseTestCase: XCTestCase {
    
    // MARK: Properties
    
    var testWindow = UIWindow(frame: UIScreen.main.bounds)
    private var expectingFailure: TestFailureExpectation?
    private var descriptionForUnexpectedFailure: String?
    
    // MARK: Setup/Teardown
    
    override func setUp() {
        
        super.setUp()
        
        testWindow = UIWindow(frame: UIScreen.main.bounds)
    }
    
    // MARK: Failure Expectations
    
    override func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: UInt, expected: Bool) {
        
        if let expectedFailure = expectingFailure, expected {
            
            var descriptionsForUnexpectedFailures = [String]()
            
            if let expectedFailureDescription = expectedFailure.description, description != expectedFailureDescription {
                descriptionsForUnexpectedFailures.append("Description mismatch - Expected: `\(expectedFailureDescription)` Actual: `\(description)`.")
            }
            
            if let expectedFailureFilePath = expectedFailure.filePath, filePath != expectedFailureFilePath {
                descriptionsForUnexpectedFailures.append("File Path mismatch - Expected: \(expectedFailureFilePath) Actual: \(filePath).")
            }
            
            if let expectedFailureLineNumber = expectedFailure.lineNumber, lineNumber != expectedFailureLineNumber {
                descriptionsForUnexpectedFailures.append("Line Number mismatch - Expected: \(expectedFailureLineNumber) Actual: \(lineNumber).")
            }
            
            if descriptionsForUnexpectedFailures.isEmpty {
                expectingFailure = nil
            }
            else {
                descriptionForUnexpectedFailure = descriptionsForUnexpectedFailures.joined(separator: " ")
                super.recordFailure(withDescription: description, inFile: filePath, atLine: lineNumber, expected: true)
            }
        }
        else {
            super.recordFailure(withDescription: description, inFile: filePath, atLine: lineNumber, expected: expected)
        }
    }
    
    func expectTestFailure(_ failure: TestFailureExpectation = TestFailureExpectation(), message: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line, inBlock testBlock: () -> Void) {
        
        expectingFailure = failure
        testBlock()
        
        if expectingFailure != nil {
            expectingFailure = nil
            let message = [message(), descriptionForUnexpectedFailure].flatMap({ $0 }).joined(separator: " ")
            descriptionForUnexpectedFailure = nil
            XCTFail(message, file: file, line: line)
        }
    }
}
