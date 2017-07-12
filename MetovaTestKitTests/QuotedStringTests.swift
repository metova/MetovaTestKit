//
//  QuotedStringTests.swift
//  MetovaTestKit
//
//  Created by Logan Gauthier on 7/11/17.
//  Copyright © 2017 Metova. All rights reserved.
//

import XCTest

@testable import MetovaTestKit

class QuotedStringTests: MTKBaseTestCase {
    
    func testQuotedString() {
        
        XCTAssertEqual(quotedString("value"), "\"value\"")
        XCTAssertEqual(quotedString(nil), "nil")
    }
}
