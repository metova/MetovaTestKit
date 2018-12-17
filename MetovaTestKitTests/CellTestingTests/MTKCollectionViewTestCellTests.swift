//
//  MTKCollectionViewTestCellTests.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 2018-12-14.
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

import XCTest

@testable import MetovaTestKit

class CollectionViewTestCellTests: MTKBaseTestCase {
    
    func testCellExistsAtIndexPathAndIsCastable() {
        let dataSource = CollectionDataSource(items: 1)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let indexPath = IndexPath(item: 0, section: 0)
        
        collectionView.dataSource = dataSource
        
        let testExecutedExpectation = expectation(description: "Test block should be executed!")
        collectionView.testCell(at: indexPath, as: MockCollectionCellTypeA.self) { testCell in
            testExecutedExpectation.fulfill()
        }
        wait(for: [testExecutedExpectation], timeout: 0)
    }
    
    func testAssertionFailureDueToMissingDataSource() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let indexPath = IndexPath(item: 0, section: 0)
        
        let description = "failed - \(collectionView) does not have a dataSource"
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: #line+1)) {
        collectionView.testCell(at: indexPath, as: UICollectionViewCell.self) { testCell in
                XCTFail("Test closure should not be called when cell can not be properly instantiated and cast.")
            }
        }
    }
    
    func testAssertionFailureDueToNoCellAtIndexPath() {
        let dataSource = CollectionDataSource()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let indexPath = IndexPath(item: 0, section: 0)
        
        collectionView.dataSource = dataSource

        let description = "failed - \(collectionView) does not have a cell at \(indexPath)"
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: #line+1)) {
            collectionView.testCell(at: indexPath, as: UICollectionViewCell.self) { testCell in
                XCTFail("Test closure should not be called when cell can not be properly instantiated and cast.")
            }
        }
    }
    
    func testAssertionFailureDoToIncorrectCellType() {
        let dataSource = CollectionDataSource(items: 3)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let indexPath = IndexPath(item: 1, section: 0)
        
        collectionView.dataSource = dataSource
        
        let description = "failed - Cell at \(indexPath) expected to be \(MockCollectionCellTypeA.self) was actually \(MockCollectionCellTypeB.self)"
        expectTestFailure(TestFailureExpectation(description: description, lineNumber: #line+1)) {
            collectionView.testCell(at: indexPath, as: MockCollectionCellTypeA.self) { testCell in
                XCTFail("Test closure should not be called when cell can not be properly instantiated and cast.")
            }
        }
    }
}

class MockCollectionCellTypeA: UICollectionViewCell {}
class MockCollectionCellTypeB: UICollectionViewCell {}

class CollectionDataSource: NSObject, UICollectionViewDataSource {
    let items: Int
    
    init(items: Int = 0) {
        self.items = items
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0: return MockCollectionCellTypeA()
        case 1: return MockCollectionCellTypeB()
        default: return UICollectionViewCell()
        }
    }
    
}
