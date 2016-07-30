//
//  MTKBrokenConstraintCounter.h
//  MetovaTestKit
//
//  Created by Nick Griffith on 7/29/16.
//  Copyright © 2016 Metova. All rights reserved.
//

#pragma GCC visibility push(hidden)

#import <UIKit/UIKit.h>

/**
 *  Executes code and counts the number of constraints UIKit broke during the test block
 *
 *  @param testBlock The block of code to test
 *
 *  @return The number of broken constraints
 */
NSUInteger MTKCountBrokenConstraints(__attribute__((noescape)) void (^ __nonnull testBlock)());

#pragma GCC visibility pop
