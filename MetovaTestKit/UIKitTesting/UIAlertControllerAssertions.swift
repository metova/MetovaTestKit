//
//  UIAlertControllerAssertions.swift
//  MetovaTestKit
//
//  Created by Logan Gauthier on 6/22/17.
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

import Foundation

/// Test that a view controller presented an alert with the specified title, message, action titles, and action styles.
///
/// - Parameters:
///   - presenter: The view controller expected to have presented the alert.
///   - style: The expected style of the alert.
///   - title: The expected title of the alert.
///   - message: The expected message of the alert.
///   - actions: The list of expected actions in the expected order.
///   - failureMessage: The message to log upon failure.
///   - file: The name of the file to report the failure for. The default value will report the file from which this method is called.
///   - line: The line number to report the failure for. The default value will report the line number of the calling site.
public func MTKAssertAlertIsPresented(by presenter: UIViewController, style: UIAlertController.Style, title: String?, message: String?, actions: [ExpectedAlertAction], _ failureMessage: String? = nil, file: StaticString = #file, line: UInt = #line) {
    
    guard let alert = presenter.presentedViewController as? UIAlertController else {
        MTKRecordFailure(withMessage: failureMessage, description: "No alert was presented.", file: file, line: line)
        return
    }
    
    guard alert.preferredStyle == style else {
        MTKRecordFailure(withMessage: failureMessage, description: "Expected alert to have style `\(style)`. Instead found `\(alert.preferredStyle)`.", file: file, line: line)
        return
    }
    
    guard alert.title == title else {
        MTKRecordFailure(withMessage: failureMessage, description: "Expected alert to have title \(quotedString(title)). Instead found \(quotedString(alert.title)).", file: file, line: line)
        return
    }
    
    guard alert.message == message else {
        MTKRecordFailure(withMessage: failureMessage, description: "Expected alert to have message \(quotedString(message)). Instead found \(quotedString(alert.message)).", file: file, line: line)
        return
    }
    
    let doActionsMatchExpectedActions: Bool = {
        
        guard actions.count == alert.actions.count else { return false }
        
        for (expectedAction, actualAction) in zip(actions, alert.actions) where !expectedAction.matchesActualAction(actualAction) {
            return false
        }
        
        return true
    }()
    
    guard doActionsMatchExpectedActions else {
        
        let expectedActionDescriptions = actions.map({ "(title: \"\($0.title)\", style: \($0.style))" }).commaSeparatedList()
        
        let actualActionDescriptions = alert.actions.map({ "(title: \(quotedString($0.title)), style: \($0.style))" }).commaSeparatedList()
        
        MTKRecordFailure(withMessage: failureMessage, description: "Expected alert to have actions: \(expectedActionDescriptions). Instead found \(actualActionDescriptions).", file: file, line: line)
        
        return
    }
}

// MARK: - ExpectedAlertAction

/// A type used to represent an expected title and style for a `UIAlertAction` instance.
public struct ExpectedAlertAction {
    
    // MARK: Properties
    
    fileprivate let title: String
    fileprivate let style: UIAlertAction.Style
    
    // MARK: Initialization
    
    /// Initialize an instance of `ExpectedAlertAction`.
    ///
    /// - Parameters:
    ///   - title: The expected title of the `UIAlertAction` you are comparing against.
    ///   - style: The expected style of the `UIAlertAction` you are comparing against.
    public init(title: String, style: UIAlertAction.Style) {
        
        self.title = title
        self.style = style
    }
    
    // MARK: Action Comparison

    fileprivate func matchesActualAction(_ action: UIAlertAction) -> Bool {
        
        return title == action.title && style == action.style
    }
}

// MARK: - UIAlertControllerStyle: CustomStringConvertible

extension UIAlertController.Style: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
        case .actionSheet:
            return ".actionSheet"
        case .alert:
            return ".alert"
        }
    }
}

// MARK: - UIAlertActionStyle: CustomStringConvertible

extension UIAlertAction.Style: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
        case .default:
            return ".default"
        case .cancel:
            return ".cancel"
        case .destructive:
            return ".destructive"
        }
    }
}
