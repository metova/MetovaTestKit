//
//  UIAlertControllerTestingTests.swift
//  HostedTests
//
//  Created by Logan Gauthier on 6/28/17.
//  Copyright © 2017 Metova. All rights reserved.
//

import XCTest
import MetovaTestKit

@testable import HostApplicationForTesting

class UIAlertControllerTestingTests: MTKBaseTestCase {
    
    // MARK: Properties
    
    var testVC: UIViewController!
    
    // MARK: Setup/Teardown
    
    override func setUp() {
        
        super.setUp()
        
        testVC = UIViewController()
        testVC.addToWindow()
    }
    
    // MARK: Test Presentation
    
    func testFailureDueToNoAlertBeingPresented() {
        
        let failureExpectation = TestFailureExpectation(description: "failed - No alert was presented.", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: [])
        }
    }
    
    // MARK: Test Style
    
    func testFailureDueToIncorrectStyle() {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have style `.actionSheet`. Instead found `.alert`.", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .actionSheet, title: "Title", message: "Message", actions: [])
        }
    }
    
    // MARK: Test Title
    
    func testFailureDueToAlertHavingIncorrectTitle() {
        
        let alert = UIAlertController(title: "Incorrect Title", message: "Message", preferredStyle: .alert)
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have title \"Title\". Instead found \"Incorrect Title\".", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: [])
        }
    }
    
    func testFailureDueToAlertHavingNilTitle() {
        
        let alert = UIAlertController(title: nil, message: "Message", preferredStyle: .alert)
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have title \"Title\". Instead found nil.", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: [])
        }
    }
    
    func testFailureDueToAlertHavingNonNilTitle() {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have title nil. Instead found \"Title\".", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: nil, message: "Message", actions: [])
        }
    }
    
    // MARK: Test Message
    
    func testFailureDueToAlertHavingIncorrectMessage() {
        
        let alert = UIAlertController(title: "Title", message: "Incorrect Message", preferredStyle: .alert)
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have message \"Message\". Instead found \"Incorrect Message\".", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: [])
        }
    }
    
    func testFailureDueToAlertHavingNilMessage() {
        
        let alert = UIAlertController(title: "Title", message: nil, preferredStyle: .alert)
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have message \"Message\". Instead found nil.", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: [])
        }
    }
    
    func testFailureDueToAlertHavingNonNilMessage() {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have message nil. Instead found \"Message\".", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: nil, actions: [])
        }
    }
    
    // MARK: Test Actions
    
    func testFailureDueToAlertHavingNoAction() {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have actions: [(title: \"Action Title\", style: .default)]. Instead found [].", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: [ExpectedAlertAction(title: "Action Title", style: .default)])
        }
    }
    
    func testFailureDueToAlertHavingIncorrectActionTitle() {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let action = UIAlertAction(title: "Incorrect Action Title", style: .default, handler: nil)
        alert.addAction(action)
        
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have actions: [(title: \"Action Title\", style: .default)]. Instead found [(title: \"Incorrect Action Title\", style: .default)].", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: [ExpectedAlertAction(title: "Action Title", style: .default)])
        }
    }
    
    func testFailureDueToAlertMissingAnAction() {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let action = UIAlertAction(title: "Action Title1", style: .default, handler: nil)
        alert.addAction(action)
        
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have actions: [(title: \"Action Title1\", style: .default), (title: \"Action Title2\", style: .default)]. Instead found [(title: \"Action Title1\", style: .default)].", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: [ExpectedAlertAction(title: "Action Title1", style: .default), ExpectedAlertAction(title: "Action Title2", style: .default)])
        }
    }
    
    func testFailureDueToAlertHavingAnExtraAction() {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Action Title1", style: .default, handler: nil)
        let action2 = UIAlertAction(title: "Action Title2", style: .default, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have actions: [(title: \"Action Title1\", style: .default)]. Instead found [(title: \"Action Title1\", style: .default), (title: \"Action Title2\", style: .default)].", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: [ExpectedAlertAction(title: "Action Title1", style: .default)])
        }
    }
    
    func testFailureDueToAlertHavingActionsInTheIncorrectOrder() {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Action Title1", style: .default, handler: nil)
        let action2 = UIAlertAction(title: "Action Title2", style: .default, handler: nil)
        alert.addAction(action2)
        alert.addAction(action1)
        
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have actions: [(title: \"Action Title1\", style: .default), (title: \"Action Title2\", style: .default)]. Instead found [(title: \"Action Title2\", style: .default), (title: \"Action Title1\", style: .default)].", filePath: #file)
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: [ExpectedAlertAction(title: "Action Title1", style: .default), ExpectedAlertAction(title: "Action Title2", style: .default)])
        }
    }
    
    func testFailureDueToAlertHavingCorrectActionTitlesAndIncorrectStyles() {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Action Title1", style: .default, handler: nil)
        let action2 = UIAlertAction(title: "Action Title2", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        
        testVC.present(alert, animated: false, completion: nil)
        
        let failureExpectation = TestFailureExpectation(description: "failed - Expected alert to have actions: [(title: \"Action Title1\", style: .default), (title: \"Action Title2\", style: .destructive)]. Instead found [(title: \"Action Title1\", style: .default), (title: \"Action Title2\", style: .cancel)].", filePath: #file)
        
        let expectedActions = [
            ExpectedAlertAction(title: "Action Title1", style: .default),
            ExpectedAlertAction(title: "Action Title2", style: .destructive)
        ]
        
        expectTestFailure(failureExpectation) {
            MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: expectedActions)
        }
    }
    
    // MARK: Test Success Case
    
    func testSuccessCaseForAlertStyle() {
        
        let alert = createSuccessCaseAlert(withStyle: .alert)
        
        testVC.present(alert, animated: false, completion: nil)
        
        let expectedActions = [
            ExpectedAlertAction(title: "Default", style: .default),
            ExpectedAlertAction(title: "Cancel", style: .cancel),
            ExpectedAlertAction(title: "Destructive", style: .destructive)
        ]
        
        MTKAssertAlertIsPresented(by: testVC, style: .alert, title: "Title", message: "Message", actions: expectedActions)
    }
    
    func testSuccessCaseForActionSheetStyle() {
        
        let alert = createSuccessCaseAlert(withStyle: .actionSheet)
        
        testVC.present(alert, animated: false, completion: nil)
        
        let expectedActions = [
            ExpectedAlertAction(title: "Default", style: .default),
            ExpectedAlertAction(title: "Cancel", style: .cancel),
            ExpectedAlertAction(title: "Destructive", style: .destructive)
        ]
        
        MTKAssertAlertIsPresented(by: testVC, style: .actionSheet, title: "Title", message: "Message", actions: expectedActions)
    }
    
    func createSuccessCaseAlert(withStyle style: UIAlertControllerStyle) -> UIAlertController {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: style)
        
        let defaultAction = UIAlertAction(title: "Default", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let destructiveAction = UIAlertAction(title: "Destructive", style: .destructive, handler: nil)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        alert.addAction(destructiveAction)
        
        return alert
    }
}
