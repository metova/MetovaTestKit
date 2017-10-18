//
//  ObjectiveCExceptionTester.h
//  MetovaTestKit
//
//  Created by Nick Griffith on 5/6/16.
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

#pragma GCC visibility push(hidden)

#import <Foundation/Foundation.h>

/**
 Synchronously tests the provided block for exceptions. If it would throw an exception, it catches the exception and returns it.
 
 @param testBlock The block to test.

 @return The caught exception. If no exception was thrown, returns `nil`.
 
 @warning You should not rely on `XCTestExpectation` fulfillment in this block. If an exception is thrown before fulfillment, the expectation will never be fulfilled. `XCTestExpectation` should be unnecessary as the block is executed synchronously.
 
 @warning This will only catch Objective-C-style exceptions. Swift's `fatalError`'s are not caught by this test.
 
 */
NSException * __nullable MTKCatchException(__attribute__((noescape)) void (^ __nonnull testBlock)(void));

#pragma GCC visibility pop
