//
//  UISegmentedControlAssertions.swift
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

/// Test that a segmented control has the expected segment titles in the expectd order. Passes if the segmented control has the specified segment titles in the specified order. Fails otherwise.
///
/// - Parameters:
///   - segmentedControl: The segmented control to test.
///   - expectedTitles: The list of expected segment titles in the expected order.
///   - failureMessage: The message to log upon failure.
///   - file: The name of the file to report the failure for. The default value will report the file from which this method is called.
///   - line: The line number to report the failure for. The default value will report the line number of the calling site.
public func MTKAssertSegmentedControl(_ segmentedControl: UISegmentedControl, hasSegmentTitles expectedTitles: [String], _ failureMessage: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) {
    
    let actualTitles = Array(0..<segmentedControl.numberOfSegments).compactMap { segmentedControl.titleForSegment(at: $0) }
    
    guard actualTitles == expectedTitles else {
        MTKRecordFailure(withMessage: failureMessage(), description: "Expected segmented control to have segment titles: \(expectedTitles.map(quotedString).commaSeparatedList()). Instead found \(actualTitles.map(quotedString).commaSeparatedList()).", file: file, line: line)
        return
    }
}
