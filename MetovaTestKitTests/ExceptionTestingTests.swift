//
//  ExceptionTestingTests.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 5/7/16.
//  Copyright © 2016 Metova. All rights reserved.
//

import XCTest

@testable import MetovaTestKit

class ExceptionTestingTests: XCTestCase {

    func testCatchExceptionReturnsNil() {
        
        var didReachEnd: Bool?
        
        let exception = MTKCatchException {
            didReachEnd = false
            
            didReachEnd = true
        }

        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertTrue(endReached)
        
        XCTAssertNil(exception)
    }
    
    func testCatchExceptionCatchesCorrectException() {
        
        var didReachEnd: Bool?
        
        let exception = MTKCatchException {
            didReachEnd = false
            
            let arr = NSArray()
            arr.objectAtIndex(3)
            
            didReachEnd = true
        }
        
        guard let endReached = didReachEnd else {
            XCTFail("Test block was not executed.")
            return
        }
        
        XCTAssertFalse(endReached)
        
        XCTAssertNotNil(exception)
    }
}
