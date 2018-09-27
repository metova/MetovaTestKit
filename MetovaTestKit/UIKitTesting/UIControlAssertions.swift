//
//  UIControlAssertions.swift
//  MetovaTestKit
//
//  Created by Logan Gauthier on 5/1/17.
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

/// Test that a control has an action method added for a particular target and event. Passes if the control has the specified target/action/event added. Fails otherwise.
///
/// - Parameters:
///   - control: The control to test.
///   - action: The message that should be sent to `target` when `controlEvent` is fired.
///   - target: The object in which `action` should be invoked on when `controlEvent` is fired.
///   - controlEvent: The event which should trigger `action` on `target`.
///   - failureMessage: The message to log upon failure.
///   - file: The name of the file to report the failure for. The default value will report the file from which this method is called.
///   - line: The line number to report the failure for. The default value will report the line number of the calling site.
public func MTKAssertControl(_ control: UIControl, sends action: Selector, to target: NSObject, for controlEvent: UIControl.Event, _ failureMessage: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) {
    
    guard let actionsForTarget = control.actions(forTarget: target, forControlEvent: controlEvent), !actionsForTarget.isEmpty else {
        MTKRecordFailure(withMessage: failureMessage(), description: "The control doesn't have any actions for the specified target", file: file, line: line)
        return
    }
    
    guard actionsForTarget.contains(NSStringFromSelector(action)) else {
        MTKRecordFailure(withMessage: failureMessage(), description: "The control doesn't have this target/action pair", file: file, line: line)
        return
    }
    
    guard target.responds(to: action) else {
        MTKRecordFailure(withMessage: failureMessage(), description: "The control has this target/action pair, but the target does not respond to the action", file: file, line: line)
        return
    }
}
