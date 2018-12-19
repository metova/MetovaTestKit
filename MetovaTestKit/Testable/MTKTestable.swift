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

/**
 
 The MTKTestable protocol provides an alternative, functional approach to `XCTest`'s built in `setUp` & `tearDown` methods for handling unit tests.
 
 `instanceForTesting()` should provide a new instance for each call.
 
 `test(_:)` should effectively follow this pattern:
 
     static func test(_ testBlock: (Self) -> Void) {
 
         let testInstance = instanceForTesting()
 
         // any code that would previously live in setUp
 
         testBlock(testInstance)
 
         // any code that would previously live in tearDown
 
     }
 
 With these methods implemented, our test cases now look like this:
 
     func testThings() {
 
         FooBarClass.test { testInstance in
 
             XCTAssertNil(testInstance.thingThatShouldBeNil)
 
         }
 
     }
 
 This allows `setUp` & `tearDown` code to exist across multiple files. Moreover, `setUp` & `tearDown` logic could now be inherited. As well, `MTKTestable` protocol extensions could be written to generalize some of the `setUp` & `tearDown` logic for large collections of types.
 
 - Note 
 `UIViewController` and its subclasses get a free implementation of `test(_:)` as long as they have implemented `instanceForTesting()`. The default `test(_:)` implementation for view controllers calls `loadView()` and `viewDidLoad()` before running the `testBlock`.
 
 */
public protocol MTKTestable {
    
    associatedtype TestableItem: Any
    
    /// Asks the `MTKTestable` type to run the given test block on an
    /// instance of the `MTKTestable` type.
    ///
    /// - Parameter testBlock: A block of code containing tests to run.
    /// - Throws: Rethrows errors thrown inside of `testBlock`
    static func test(_ testBlock: (TestableItem) throws -> Void) rethrows
    
    /// Asks the `MTKTestable` type for a new instance in order to be
    /// used for testing. This method should provide a new instance
    /// every time.
    ///
    /// - Returns: A new instance, ready for testing.
    static func instanceForTesting() -> Self
}
