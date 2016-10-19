//
//  TestableViewController.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 5/7/16.
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

import UIKit
@testable import MetovaTestKit

// This class exists for the purposes of testing the MTKTestable protocol.  In a real project, the class definition would exist in the main target.  The MTKTestable extension would exist in a separate file and only part of the test target.

class TestableViewController: UIViewController {

    static let TestLabelString = "Test Label String"
    static let TestButtonString = "Test Button String"
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var testButton: UIButton!
    
    required init() {
        super.init(nibName: "TestableViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.text = TestableViewController.TestLabelString
        testButton.setTitle(TestableViewController.TestButtonString, for: .normal)
    }
}

// Implementing this method and marking conformance to MTKTestable protocol means we inherit the default implementation of the test(_:) method defined in the extension for the protocol for UIViewControllers.

extension TestableViewController: MTKTestable {
    
    static func instanceForTesting() -> Self {
        return self.init()
    }
}
