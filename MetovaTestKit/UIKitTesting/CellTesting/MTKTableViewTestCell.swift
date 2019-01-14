//
//  MTKTableViewTestCell.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 11/29/18.
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

import XCTest

/// This method attempts to produce a table view cell from the table view at the specified index path.  It then attempts to cast the cell to the specified type.  If either of these two fail, this function will produce a test failure and the test block will not be executed.  If both pass, the resulting cell, cast to the specified type, will be passed into the testBlock where the developer can run further assertions on the cell.
///
/// - Parameters:
///   - tableView: Table view to grab a cell from.
///   - indexPath: IndexPath to grab a cell from.
///   - cellType: Type of cell to cast to before passing into test block.
///   - file: The file the test is called from.
///   - line: The line the test is called from.
///   - testBlock: A block of code containing tests to run.  This block is not guaranteed to execute.  If it does not execute, this method will fail the test.
/// - Throws: Rethrows any error thrown by the test block.  Does not throw any errors on its own.
public func MTKTestCell<T: UITableViewCell>(
    in tableView: UITableView,
    at indexPath: IndexPath,
    as cellType: T.Type = T.self,
    file: StaticString = #file,
    line: UInt = #line,
    test testBlock: (T) throws -> Void
) rethrows {
    guard let dataSource = tableView.dataSource else {
        XCTFail("\(tableView) does not have a dataSource", file: file, line: line)
        return
    }
    
    let tableSectionCount = dataSource.numberOfSections?(in: tableView) ?? 1
    guard
        indexPath.section < tableSectionCount,
        indexPath.row < dataSource.tableView(tableView, numberOfRowsInSection: indexPath.section)
    else {
        XCTFail("\(tableView) does not have a cell at \(indexPath)", file: file, line: line)
        return
    }

    let cell = dataSource.tableView(tableView, cellForRowAt: indexPath)
    guard let typedCell = cell as? T else {
        XCTFail("Cell at \(indexPath) expected to be \(T.self) was actually \(type(of: cell))", file: file, line: line)
        return
    }
    
    try testBlock(typedCell)
}
