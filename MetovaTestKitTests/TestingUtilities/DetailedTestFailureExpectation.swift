//
//  DetailedTestFailureExpectation.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 2018-12-27.
//  Copyright © 2018 Metova. All rights reserved.
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

struct DetailedTestFailureExpectation: TestFailureExpectation {
    
    let descriptionSubstrings: [String]?
    let filePath: String?
    let lineNumber: UInt?
    
    init(descriptionSubstrings: [String]? = nil, filePath: String? = nil, lineNumber: UInt? = nil) {
        self.descriptionSubstrings = descriptionSubstrings
        self.filePath = filePath
        self.lineNumber = lineNumber
    }
    
    func verifyDescription(_ description: String) -> TestVerificationResult {
        guard let expectedSubstrings = descriptionSubstrings else { return .expected }
        
        let missingSubstrings = expectedSubstrings.filter { !description.contains($0) }

        guard missingSubstrings.isEmpty else {
            return .mismatch("Description mismatch\nActual:***\n\(description)`\n***\nmissing substrings:\n\t\(missingSubstrings.joined(separator: "\n\t"))")
        }
        
        return .expected
    }
    
    func verifyFilePath(_ filePath: String) -> TestVerificationResult {
        guard let expectedFilePath = self.filePath else { return .expected }
        
        guard filePath == expectedFilePath else {
            return .mismatch("File Path mismatch - Expected: `\(expectedFilePath)` Actual: `\(filePath)`")
        }
        
        return .expected
    }
    
    func verifyLineNumber(_ lineNumber: Int) -> TestVerificationResult {
        guard let expectedLineNumber = self.lineNumber else { return .expected }
        
        guard lineNumber == expectedLineNumber else {
            return .mismatch("Line Number mismatch - Expected: `\(expectedLineNumber)` Actual: `\(lineNumber)`")
        }
        
        return .expected
    }
}
