//
//  MTKTestable+UIViewController.swift
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

public extension MTKTestable where Self: UIViewController {
    
    /// Instantiates a new testable instance of a `UIViewController` or
    /// subclass using `instanceForTesting`, executes `loadView` &
    /// `viewDidLoad` to prepare the view controller for testing, and
    /// then runs the `testBlock` with this new instance.
    ///
    /// - Parameter testBlock: The block of tests to run.
    /// - Throws: Rethrows errors thrown inside of `testBlock`
    static func test(_ testBlock: (Self) throws -> Void) rethrows {
        let testVC = instanceForTesting()
        testVC.loadView()
        testVC.viewDidLoad()
        try testBlock(testVC)
    }
}
