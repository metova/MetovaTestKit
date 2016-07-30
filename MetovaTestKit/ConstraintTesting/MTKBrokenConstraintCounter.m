//
//  MTKBrokenConstraintCounter.m
//  MetovaTestKit
//
//  Created by Nick Griffith on 7/29/16.
//  Copyright © 2016 Metova. All rights reserved.
//

#import "MTKBrokenConstraintCounter.h"
#import <objc/runtime.h>

@interface UIView (AutoLayout)

- (void)                    engine:(id /* NSISEngine */)engine
               willBreakConstraint:(NSLayoutConstraint *)breakConstraint
 dueToMutuallyExclusiveConstraints:(NSArray<NSLayoutConstraint *> *)mutuallyExclusiveConstraints;

@end

NSUInteger MTKCountBrokenConstraints(__attribute__((noescape)) void (^ __nonnull testBlock)()) {
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
