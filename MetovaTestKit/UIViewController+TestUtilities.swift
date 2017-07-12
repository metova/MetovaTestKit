//
//  UIViewController+TestUtilities.swift
//  MetovaTestKit
//
//  Created by Logan Gauthier on 6/27/17.
//  Copyright © 2017 Metova. All rights reserved.
//

import Foundation

extension UIViewController {
    
    /// Sets this view controller as the root view controller of the key window.
    public func addToWindow() {
        
        UIApplication.shared.keyWindow?.rootViewController = self
    }
}
