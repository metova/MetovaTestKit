//
//  ConstraintTestingTests.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 7/29/16.
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

extension NSLayoutConstraint {
    
    convenience init(view: UIView, width: CGFloat) {
        self.init(item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: width
        )
    }
}

class ConstraintTestingTests: MTKBaseTestCase {

    func testBrokenConstraintCount() {
        
        let count = MTKAssertNoBrokenConstraints {
            let window = UIWindow()
            let view = UIView()
            
            window.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.addConstraint(NSLayoutConstraint(view: view, width: 200))
            
            view.updateConstraints()
        }
        
        XCTAssertEqual(0, count)
    }
    
    func testAssertNoBrokenConstraintsFails() {
        
        let message = "Broken constraints!"
        let description = "XCTAssertEqual failed: (\"0\") is not equal to (\"2\") - \(message)"
        
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 75)) {
            
            let count = MTKAssertNoBrokenConstraints(message: message) {
                let window = UIWindow()
                let view = UIView()
                
                window.addSubview(view)
                
                view.translatesAutoresizingMaskIntoConstraints = false
                
                view.addConstraint(NSLayoutConstraint(view: view, width: 50))
                view.addConstraint(NSLayoutConstraint(view: view, width: 100))
                view.addConstraint(NSLayoutConstraint(view: view, width: 200))
                
                view.updateConstraints()
            }
            
            XCTAssertEqual(2, count)
        }
    }
    
    func testAssertNoBrokenConstraintsDefaultMessageFails() {
        
        let defaultMessage = "Found 2 broken constraints while executing test block."
        let description = "XCTAssertEqual failed: (\"0\") is not equal to (\"2\") - \(defaultMessage)"
        
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 101)) {
            
            let count = MTKAssertNoBrokenConstraints {
                let window = UIWindow()
                let view = UIView()
                
                window.addSubview(view)
                
                view.translatesAutoresizingMaskIntoConstraints = false
                
                view.addConstraint(NSLayoutConstraint(view: view, width: 50))
                view.addConstraint(NSLayoutConstraint(view: view, width: 100))
                view.addConstraint(NSLayoutConstraint(view: view, width: 200))
                
                view.updateConstraints()
            }
            
            XCTAssertEqual(2, count)
        }
    }
}
