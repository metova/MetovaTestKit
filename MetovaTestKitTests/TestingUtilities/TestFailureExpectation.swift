//
//  TestFailureExpectation.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 2018-12-27.
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

enum TestVerificationResult {
    case expected
    case mismatch(String)
}

protocol TestFailureExpectation {
    func verifyDescription(_ description: String) -> TestVerificationResult
    func verifyFilePath(_ filePath: String) -> TestVerificationResult
    func verifyLineNumber(_ lineNumber: Int) -> TestVerificationResult
}

extension TestFailureExpectation {
    func verifyDescription(_ description: String) -> TestVerificationResult { return .expected }
    func verifyFilePath(_ filePath: String) -> TestVerificationResult { return .expected }
    func verifyLineNumber(_ lineNumber: Int) -> TestVerificationResult { return .expected }
}
