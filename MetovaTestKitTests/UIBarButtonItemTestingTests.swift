//
//  UIBarButtonItemTestingTests.swift
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

@testable import MetovaTestKit

// MARK: - TestViewController

private class TestViewController: UIViewController {
    
    func testAction() {}
    func someOtherAction() {}
}

// MARK: - UIBarButtonItemAssertionsTests

class UIBarButtonItemTestingTests: MTKBaseTestCase {
    
    // MARK: Properties
    
    fileprivate let testVC = TestViewController()
    
    // MARK: Tests
    
    func testTargetActionSuccess() {
        
        let barButtonItem = UIBarButtonItem(title: "", style: .plain, target: testVC, action: #selector(TestViewController.testAction))
        MTKAssertBarButtonItem(barButtonItem, sends: #selector(TestViewController.testAction), to: testVC)
    }
    
    func testFailureDueToNoAction() {
        
        let failureExpectation = TestFailureExpectation(description: "failed - The bar button item's action is nil.", filePath: #file)

        expectTestFailure(failureExpectation) {
            
            let barButtonItem = UIBarButtonItem(title: "", style: .plain, target: testVC, action: nil)
            MTKAssertBarButtonItem(barButtonItem, sends: #selector(TestViewController.testAction), to: testVC)
        }
    }
    
    func testFailureDueToWrongAction() {
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected the bar button item to have action `testAction`. Instead found `someOtherAction`.", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            
            let barButtonItem = UIBarButtonItem(title: "", style: .plain, target: testVC, action: #selector(TestViewController.someOtherAction))
            MTKAssertBarButtonItem(barButtonItem, sends: #selector(TestViewController.testAction), to: testVC)
        }
    }
    
    func testFailureDueToNoTarget() {
        
        let failureExpectation = TestFailureExpectation(description: "failed - The bar button item's target is nil.", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            
            let barButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: #selector(TestViewController.testAction))
            MTKAssertBarButtonItem(barButtonItem, sends: #selector(TestViewController.testAction), to: testVC)
        }
    }
    
    func testFailureDueToWrongTarget() {
        
        let otherTarget = TestViewController()
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected the bar button item to have target `\(testVC)`. Instead found `\(otherTarget)`.", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            
            let barButtonItem = UIBarButtonItem(title: "", style: .plain, target: otherTarget, action: #selector(TestViewController.testAction))
            MTKAssertBarButtonItem(barButtonItem, sends: #selector(TestViewController.testAction), to: testVC)
        }
    }
    
    func testFailureDueToTargetNotRespondingToAction() {
        
        let failureExpectation = TestFailureExpectation(description: "failed - The target does not respond to the action.", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            
            let testVCThatDoesNotRespondToSelector = UIViewController()
            let barButtonItem = UIBarButtonItem(title: "", style: .plain, target: testVCThatDoesNotRespondToSelector, action: #selector(TestViewController.testAction))
            MTKAssertBarButtonItem(barButtonItem, sends: #selector(TestViewController.testAction), to: testVCThatDoesNotRespondToSelector)
        }
    }
}
