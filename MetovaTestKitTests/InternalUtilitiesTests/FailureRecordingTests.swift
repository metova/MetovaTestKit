//
//  FailureRecordingTests.swift
//  MetovaTestKit
//
//  Created by Logan Gauthier on 5/2/17.
//  Copyright © 2017 Metova. All rights reserved.
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

class FailureRecordingTests: MTKBaseTestCase {
    
    func testFailureDescriptionFormation() {
        
        XCTAssertEqual(failureDescription(withMessage: "User Message", description: "Specific reason why test failed"), "Specific reason why test failed - User Message")
        
        XCTAssertEqual(failureDescription(withMessage: nil, description: "Specific reason why test failed"), "Specific reason why test failed")
    }
    
    func testRecordingFailureWithMessageAndDescription() {
        
        let line: UInt = 100
        let testFailureExpectation = BasicTestFailureExpectation(description: "failed - Description - Message", filePath: #file, lineNumber: line)
        
        expectTestFailure(testFailureExpectation) {
            MTKRecordFailure(withMessage: "Message", description: "Description", file: #file, line: line)
        }
    }
}
