//
//  ConstraintTestingTests.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 7/29/16.
//  Copyright © 2016 Metova. All rights reserved.
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
        let description = "XCTAssertEqual failed: (\"Optional(0)\") is not equal to (\"Optional(2)\") - \(message)"
        
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 54)) {
            
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
        let description = "XCTAssertEqual failed: (\"Optional(0)\") is not equal to (\"Optional(2)\") - \(defaultMessage)"
        
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: 81)) {
            
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
