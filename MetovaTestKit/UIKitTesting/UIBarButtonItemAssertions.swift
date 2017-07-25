//
//  UIBarButtonItemAssertions.swift
//  MetovaTestKit
//
//  Created by Logan Gauthier on 7/19/17.
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

/// Passes if the bar button item has the specified target/action and the target responds to the action. Fails otherwise.
///
/// - Parameters:
///   - barButtonItem: The bar button item to test.
///   - action: The message that should be sent to `target`.
///   - target: The object that the `action` should be sent to.
///   - failureMessage: The message to log upon failure.
///   - file: The name of the file to report the failure for. The default value will report the file from which this method is called.
///   - line: The line number to report the failure for. The default value will report the line number of the calling site.
public func MTKAssertBarButtonItem(_ barButtonItem: UIBarButtonItem, sends action: Selector, to target: NSObject, _ failureMessage: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) {
    
    guard let actualAction = barButtonItem.action else {
        MTKRecordFailure(withMessage: failureMessage(), description: "The bar button item's action is nil.", file: file, line: line)
        return
    }
    
    guard actualAction == action else {
        MTKRecordFailure(withMessage: failureMessage(), description: "Expected the bar button item to have action `\(action)`. Instead found `\(actualAction)`.", file: file, line: line)
        return
    }
    
    guard let actualTarget = barButtonItem.target else {
        MTKRecordFailure(withMessage: failureMessage(), description: "The bar button item's target is nil.", file: file, line: line)
        return
    }
    
    guard actualTarget === target else {
        MTKRecordFailure(withMessage: failureMessage(), description: "Expected the bar button item to have target `\(target)`. Instead found `\(actualTarget)`.", file: file, line: line)
        return
    }
    
    guard actualTarget.responds(to: actualAction) else {
        MTKRecordFailure(withMessage: failureMessage(), description: "The target does not respond to the action.", file: file, line: line)
        return
    }
}
