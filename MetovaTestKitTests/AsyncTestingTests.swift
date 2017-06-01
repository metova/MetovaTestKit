//
//  AsyncTestingTests.swift
//  MetovaTestKit
//
//  Created by Logan Gauthier on 5/5/17.
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

class AsyncTestingTests: MTKBaseTestCase {
    
    // MARK: WaitDurationTester
    
    class WaitDurationTester {
        
        private var startTime: CFTimeInterval?
        private var endTime: CFTimeInterval?
        
        func beginRecordingDuration() {
            
            startTime = CACurrentMediaTime()
        }
        
        func endRecordingDuration(file: StaticString = #file, line: UInt = #line) {
            
            guard startTime != nil else {
                XCTFail("Attempting to end duration recording prior to initiating it. You must call `beginRecordingDuration` before calling `endRecordingDuration`.", file: file, line: line)
                return
            }
            
            endTime = CACurrentMediaTime()
        }
        
        func assertActualDurationMatches(expectedDuration: TimeInterval, file: StaticString = #file, line: UInt = #line) {
            
            guard let endTime = endTime, let startTime = startTime else {
                XCTFail("Failed to capture the start or end time for calculating the wait duration.", file: file, line: line)
                return
            }
            
            let actualDuration = endTime - startTime
            
            XCTAssertEqualWithAccuracy(actualDuration, expectedDuration, accuracy: 0.3, file: file, line: line)
            XCTAssertTrue(actualDuration >= expectedDuration, "Because the test action is dispatched after the expected duration, the actual recorded duration (\(actualDuration) seconds) should never be less than the expected duration (\(expectedDuration) seconds).")
        }
    }
    
    // MARK: Tests

    func testSuccessfulAsyncTest() {
        
        func performTest(usingSpecificQueue queue: DispatchQueue? = nil, line: UInt = #line) {
            
            let waitDurationTester = WaitDurationTester()
            waitDurationTester.beginRecordingDuration()

            let testAction = {
                waitDurationTester.endRecordingDuration(line: line)
            }
            
            if let queue = queue {
                MTKWaitThenContinueTest(after: 2, on: queue, testAction: testAction)
            }
            else {
                MTKWaitThenContinueTest(after: 2, testAction: testAction)
            }
            
            waitDurationTester.assertActualDurationMatches(expectedDuration: 2, line: line)
        }
        
        performTest()
        performTest(usingSpecificQueue: .global())
    }
    
    func testAsyncTestFailsWhenAssertionFailsInTheTestActionClosure() {
        
        func performTest(usingSpecificQueue queue: DispatchQueue? = nil, line: UInt = #line) {
            
            let expectedFailure = TestFailureExpectation(description: "Description", filePath: "File", lineNumber: 1)
            
            expectTestFailure(expectedFailure) {
                
                let waitDurationTester = WaitDurationTester()
                waitDurationTester.beginRecordingDuration()
                
                MTKWaitThenContinueTest(after: 1) {
                    waitDurationTester.endRecordingDuration(line: line)
                    self.recordFailure(withDescription: "Description", inFile: "File", atLine: 1, expected: true)
                }
                
                waitDurationTester.assertActualDurationMatches(expectedDuration: 1, line: line)
            }
        }
        
        performTest()
        performTest(usingSpecificQueue: .global())
    }
}
