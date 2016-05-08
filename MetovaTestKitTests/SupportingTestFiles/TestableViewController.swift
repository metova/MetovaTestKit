//
//  TestableViewController.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 5/7/16.
//  Copyright © 2016 Metova. All rights reserved.
//

import UIKit
@testable import MetovaTestKit

// This class exists for the purposes of testing the MTKTestable protocol.  In a real project, the class definition would exist in the main target.  The MTKTestable extension would exist in a separate file and only part of the test target.

class TestableViewController: UIViewController {

    static let TestLabelString = "Test Label String"
    static let TestButtonString = "Test Button String"
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var testButton: UIButton!
    
    required init() {
        super.init(nibName: "TestableViewController", bundle: NSBundle(forClass: self.dynamicType))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.text = TestableViewController.TestLabelString
        testButton.setTitle(TestableViewController.TestButtonString, forState: .Normal)
    }
}



// Implementing this method and marking conformance to MTKTestable protocol means we inherit the default implementation of the test(_:) method defined in the extension for the protocol for UIViewControllers.

extension TestableViewController: MTKTestable {
    
    static func instanceForTesting() -> Self {
        return self.init()
    }
    
}
