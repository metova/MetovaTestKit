//
//  UISegmentedControlTestingTests.swift
//  MetovaTestKit
//
//  Created by Logan Gauthier on 5/4/17.
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

class UISegmentedControlTestingTests: MTKBaseTestCase {
    
    func testSegmentTitlesAssertionSuccess() {
        
        let segmentedControl = UISegmentedControl(items: ["Title 1", "Title 2", "Title 3"])
        MTKAssertSegmentedControl(segmentedControl, hasSegmentTitles: ["Title 1", "Title 2", "Title 3"])
    }
    
    func testSegmentTitlesAssertionExtraUnexpectedTitleFailure() {
        
        let segmentedControl = UISegmentedControl(items: ["Title 1", "Title 2"])
        
        let failureExpectation = TestFailureExpectation(description: "Expected segmented control to have segment titles: \"Title 1\". Instead found \"Title 1\", and \"Title 2\".", filePath: #file)
        
        expectTestFailure(failureExpectation, message: "The control has an extra title that we're not expecting.") {
            MTKAssertSegmentedControl(segmentedControl, hasSegmentTitles: ["Title 1"])
        }
    }
    
    func testSegmentTitlesAssertionMissingTitleFailure() {
        
        let segmentedControl = UISegmentedControl(items: ["Title 1"])
        
        let failureExpectation = TestFailureExpectation(description: "Expected segmented control to have segment titles: \"Title 1\", and \"Title 2\". Instead found \"Title 1\".", filePath: #file)
        
        expectTestFailure(failureExpectation, message: "The control is missing a title that we're expecting.") {
            MTKAssertSegmentedControl(segmentedControl, hasSegmentTitles: ["Title 1", "Title 2"])
        }
    }
    
    func testSegmentTitlesAssertionWrongTitleFailure() {
        
        let segmentedControl = UISegmentedControl(items: ["Title 1", "Title 2"])
        
        let failureExpectation = TestFailureExpectation(description: "Expected segmented control to have segment titles: \"Title 1\", and \"Different Title\". Instead found \"Title 1\", and \"Title 2\".", filePath: #file)
        
        expectTestFailure(failureExpectation, message: "One of the titles is different from the one we're expecting.") {
            MTKAssertSegmentedControl(segmentedControl, hasSegmentTitles: ["Title 1", "Different Title"])
        }
    }
    
    func testSegmentTitlesAssertionWrongTitlesOrderFailure() {
        
        let segmentedControl = UISegmentedControl(items: ["Title 1", "Title 2"])
        
        let failureExpectation = TestFailureExpectation(description: "Expected segmented control to have segment titles: \"Title 2\", and \"Title 1\". Instead found \"Title 1\", and \"Title 2\".", filePath: #file)
        
        expectTestFailure(failureExpectation, message: "The titles are in a different order than what we're expecting.") {
            MTKAssertSegmentedControl(segmentedControl, hasSegmentTitles: ["Title 2", "Title 1"])
        }
    }
}
