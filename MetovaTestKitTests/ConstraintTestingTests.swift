//
//  ConstraintTestingTests.swift
//  MetovaTestKit
//
//  Created by Nick Griffith on 7/29/16.
//  Copyright © 2016 Metova. All rights reserved.
//

import XCTest

@testable import MetovaTestKit

class ConstraintTestingTests: MTKBaseTestCase {

    func testBrokenConstraintCount() {
        let count = MTKAssertNoBrokenConstraints {
            // doing nothing should break no constraints
            // TODO: Do some real UIView work that doesn't break constraints.
        }
        
        XCTAssertEqual(0, count)
    }
    
    func testAssertNoBrokenConstraintsFails() {
        // TODO: Find a way to verify that a broken constraint will cause MTKAssertNoBrokenConstraints to fail and cause THIS test to pass.
    }

}
