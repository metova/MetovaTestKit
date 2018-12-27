//
//  MTKDateTestingTests.swift
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

@testable import MetovaTestKit

class DateTestingTests: MTKBaseTestCase {
    
    func testIdenticalDatesPassAssertion() {
        let components = DateComponents(calendar: nil, timeZone: nil, era: 0, year: 2018, month: 12, day: 25, hour: 6, minute: 57, second: 42, nanosecond: 8675309, weekday: 3, weekdayOrdinal: 4, quarter: 4, weekOfMonth: 4, weekOfYear: 52, yearForWeekOfYear: 2018)
        guard let date1 = Calendar.current.date(from: components), let date2 = Calendar.current.date(from: components) else {
            XCTFail("Failed to instantiate test dates!")
            return
        }
        
        MTKAssertEqualDates(date1, date2, comparing: .era, .year, .month, .day, .hour, .minute, .second, .nanosecond, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear)
    }
    
    func testAlmostIdenticalDatesPassSpecificComponentAssertion() {
        var components = DateComponents()
        components.year = 2018
        components.month = 12
        components.day = 25
        components.hour = 6
        components.minute = 57
        components.second = 42
        components.nanosecond = 867309
        guard let date1 = Calendar.current.date(from: components) else {
            XCTFail("Failed to instantiate test date 1!")
            return
        }
        
        components.nanosecond = 0
        guard let date2 = Calendar.current.date(from: components) else {
            XCTFail("Failed to instantiate test date 2!")
            return
        }
        
        MTKAssertEqualDates(date1, date2, comparing: .year, .month, .day, .hour, .minute, .second)
    }
    
    func testAlmostIdenticalDatesFailSpecificComponentAssertion() {
        var components = DateComponents()
        components.year = 2018
        components.month = 12
        components.day = 25
        components.hour = 6
        components.minute = 57
        components.second = 42
        guard let date1 = Calendar.current.date(from: components) else {
            XCTFail("Failed to instantiate test date 1!")
            return
        }
        
        components.second = 43
        guard let date2 = Calendar.current.date(from: components) else {
            XCTFail("Failed to instantiate test date 2!")
            return
        }
        
        let description = "failed - \n  second value (42) of lhs is not equal to second value (43) of rhs"
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: #line+1)) {
            MTKAssertEqualDates(date1, date2, comparing: .year, .month, .day, .hour, .minute, .second)
        }
    }
    
    func testDisplaysCustomMessageOnFailure() {
        var components = DateComponents()
        components.year = 2018
        components.month = 12
        components.day = 25
        components.hour = 6
        components.minute = 57
        components.second = 42
        guard let date1 = Calendar.current.date(from: components) else {
            XCTFail("Failed to instantiate test date 1!")
            return
        }
        
        components.second = 43
        guard let date2 = Calendar.current.date(from: components) else {
            XCTFail("Failed to instantiate test date 2!")
            return
        }
        
        let description = "failed - MTKAssertEqualDates failure - Custom Message!"
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: #line+1)) {
            MTKAssertEqualDates(date1, date2, comparing: .year, .month, .day, .hour, .minute, .second, .nanosecond, message: "Custom Message!")
        }
    }
}
