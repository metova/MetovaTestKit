//
//  UIControlTestingTests.swift
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

@testable import MetovaTestKit

// MARK: - TestViewController

private class TestViewController: UIViewController {
    
    func didFireControlEvent() {}
    func didFireOtherControlEvent() {}
}

// MARK: - UIControlTestingTests

class UIControlTestingTests: MTKBaseTestCase {
    
    // MARK: Properties
    
    let allEvents: [UIControlEvents] = [
        .touchDown,
        .touchDownRepeat,
        .touchDragInside,
        .touchDragOutside,
        .touchDragEnter,
        .touchDragExit,
        .touchUpInside,
        .touchUpOutside,
        .touchCancel,
        .valueChanged,
        .editingDidBegin,
        .editingChanged,
        .editingDidEnd,
        .editingDidEndOnExit
    ]
    
    fileprivate let testVC = TestViewController()
    
    // MARK: Tests
    
    func testTargetActionSuccess() {
        
        for event in allEvents {
            let control = UIControl()
            control.addTarget(testVC, action: #selector(TestViewController.didFireControlEvent), for: event)
            MTKAssertControl(control, sends: #selector(TestViewController.didFireControlEvent), to: testVC, for: event, "This shouldn't fail because the control has the target/action/event combination that we are testing for.")
        }
    }
    
    func testTargetActionFailureWithNoActionsRegistered() {
        
        expectTestFailure(message: "This control doesn't have any actions added.") {
            let control = UIControl()
            MTKAssertControl(control, sends: #selector(TestViewController.didFireControlEvent), to: testVC, for: .touchUpInside)
        }
    }
    
    func testTargetActionFailureWithWrongEvent() {
        
        expectTestFailure(message: "This control has this target/action added, but it's for a different event.") {
            let control = UIControl()
            control.addTarget(testVC, action: #selector(TestViewController.didFireControlEvent), for: .touchDown)
            MTKAssertControl(control, sends: #selector(TestViewController.didFireControlEvent), to: testVC, for: .touchUpInside)
        }
    }
    
    func testTargetActionFailureWithWrongAction() {
        
        expectTestFailure(message: "This control has an action registered for this target and event, but it's a different action than the one we're checking.") {
            let control = UIControl()
            control.addTarget(testVC, action: #selector(TestViewController.didFireOtherControlEvent), for: .touchUpInside)
            MTKAssertControl(control, sends: #selector(TestViewController.didFireControlEvent), to: testVC, for: .touchUpInside)
        }
    }
    
    func testTargetActionFailureWithWrongTarget() {
        
        expectTestFailure(message: "This control has this action added for this event, but it's for a different target.") {
            let otherVC = TestViewController()
            let control = UIControl()
            control.addTarget(otherVC, action: #selector(TestViewController.didFireControlEvent), for: .touchUpInside)
            MTKAssertControl(control, sends: #selector(TestViewController.didFireControlEvent), to: testVC, for: .touchUpInside)
        }
    }
    
    func testTargetActionFailureWithTargetThatDoesNotRespondToAction() {
        
        expectTestFailure(message: "This control has the correct target/action/event registered, but the target does not respond to this action.") {
            let testVCThatDoesNotRespondToSelector = UIViewController()
            let control = UIControl()
            control.addTarget(testVCThatDoesNotRespondToSelector, action: #selector(TestViewController.didFireControlEvent), for: .touchUpInside)
            MTKAssertControl(control, sends: #selector(TestViewController.didFireControlEvent), to: testVCThatDoesNotRespondToSelector, for: .touchUpInside)
        }
    }
}
