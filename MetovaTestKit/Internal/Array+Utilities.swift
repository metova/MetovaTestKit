//
//  Array+Utilities.swift
//  MetovaTestKit
//
//  Created by Logan Gauthier on 5/2/17.
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

import Foundation

extension Sequence where Iterator.Element == String {
    
    /// Convenience method for generating a comma separated list of items in qutoes. The last item will be preceded with "and" as well as an Oxford comma.
    ///
    /// - Returns: A comma separated list of items where each item is surrounded by quotes.
    func commaSeparatedQuotedList() -> String {
        
        var itemsInQuotes = map { "\"\($0)\"" }
        
        if itemsInQuotes.count > 1 {
            let lastItem = itemsInQuotes.removeLast()
            return itemsInQuotes.joined(separator: ", ") + ", and \(lastItem)"
        }
        
        return itemsInQuotes.joined(separator: ", ")
    }
}
