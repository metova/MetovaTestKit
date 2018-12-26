//
//  FailureRecording.swift
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

/// Convenience method for use within MTK assertions to record a failure with a description that includes the user's assertion message along with MTK's failure description.
///
/// - Parameters:
///   - message: The user's assertion message.
///   - description: The description of what specifically failed.
///   - file: The name of the file from which the failure occurred.
///   - line: The line number where the failure occurred.
func MTKRecordFailure(withMessage message: String?, description: String, file: StaticString, line: UInt) {
    
    let fullDescription = failureDescription(withMessage: message, description: description)
    XCTFail(fullDescription, file: file, line: line)
}

/// Convenience method for constructing a failure description that includes the user's assertion message along with the description of what specifically failed.
///
/// - Parameters:
///   - message: The user's assertion message.
///   - description: The description of what specifically failed.
/// - Returns: The combined description and message formatted similar to standard XCTest failure descriptions.
func failureDescription(withMessage message: String?, description: String) -> String {
    
    if let message = message {
        return "\(description) - \(message)"
    }
    
    return description
}
