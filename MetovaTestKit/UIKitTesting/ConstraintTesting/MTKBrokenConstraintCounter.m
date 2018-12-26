//
//  MTKBrokenConstraintCounter.m
//  MetovaTestKit
//
//  Created by Nick Griffith on 7/29/16.
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

#import "MTKBrokenConstraintCounter.h"
#import <objc/runtime.h>

@interface UIView (AutoLayout)

- (void)                    engine:(id /* NSISEngine */)engine
               willBreakConstraint:(NSLayoutConstraint *)breakConstraint
 dueToMutuallyExclusiveConstraints:(NSArray<NSLayoutConstraint *> *)mutuallyExclusiveConstraints;

@end

NSUInteger MTKCountBrokenConstraints(__attribute__((noescape)) void (^ __nonnull testBlock)(void)) {
    __block NSUInteger brokenConstraintCount = 0;
    
    SEL brokenConstraintSelector = @selector(engine:willBreakConstraint:dueToMutuallyExclusiveConstraints:);
    Method brokenConstraintMethod = class_getInstanceMethod([UIView class], brokenConstraintSelector);
    void (*originalImp)(id, SEL, id, NSLayoutConstraint *, NSArray<NSLayoutConstraint *> *) = (void*) method_getImplementation(brokenConstraintMethod);
    
    void (^swizzleBlock)(id _self, id engine, NSLayoutConstraint *constraint, NSArray<NSLayoutConstraint *> *conflictingConstraints)
    = ^void(id _self, id engine, NSLayoutConstraint *constraint, NSArray<NSLayoutConstraint *> *conflictingConstraints) {
        
        originalImp(_self, brokenConstraintSelector, engine, constraint, conflictingConstraints);
        
        brokenConstraintCount++;
    };
    
    void (*swizzleFunc)(id, SEL, id, NSLayoutConstraint *, NSArray<NSLayoutConstraint *> *) = (void*) imp_implementationWithBlock(swizzleBlock);
    
    method_setImplementation(brokenConstraintMethod, (IMP)swizzleFunc);
    testBlock();
    method_setImplementation(brokenConstraintMethod, (IMP)originalImp);
    
    return brokenConstraintCount;
}
