//
//  MTKDateTesting.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 2019-12-26.
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

/// Compares two dates using only the provided components.  If any of the provided components are mismatched between the two dates, the test fails.  If no components are provided, the test always passes.
///
/// - Parameters:
///   - lhs: A `Date` to compare.
///   - rhs: A `Date` to compare.
///   - components: Components to use to compare the two dates.
///   - calendar: Calendar to use to pull components out of dates.  Defaults to `.current`.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func MTKAssertEqualDates(_ lhs: Date, _ rhs: Date, comparing components: Calendar.Component..., calendar: Calendar = .current, message: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) {
    MTKAssertEqualDates(lhs, rhs, comparing: Set(components), calendar: calendar, message: message, file: file, line: line)
}

/// Compares two dates using only the provided components.  If any of the provided components are mismatched between the two dates, the test fails.  If no components are provided, the test always passes.
///
/// - Parameters:
///   - lhs: A `Date` to compare.
///   - rhs: A `Date` to compare.
///   - components: Components to use to compare the two dates.
///   - calendar: Calendar to use to pull components out of dates.  Defaults to `.current`.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func MTKAssertEqualDates(_ lhs: Date, _ rhs: Date, comparing components: Set<Calendar.Component>, calendar: Calendar = .current, message: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) {

    var failureMessage = ""
    
    for component in components {
        let lhsComponent = calendar.component(component, from: lhs)
        let rhsComponent = calendar.component(component, from: rhs)

        if lhsComponent != rhsComponent {
            if let message = message() {
                XCTFail("MTKAssertEqualDates failure - \(message)", file: file, line: line)
                return
            }
            
            failureMessage += "\n  \(component) value (\(lhsComponent)) of lhs is not equal to \(component) value (\(rhsComponent)) of rhs"
        }
    }
    
    if !failureMessage.isEmpty {
        XCTFail(failureMessage, file: file, line: line)
    }
}
