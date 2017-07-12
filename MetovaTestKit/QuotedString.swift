//
//  QuotedString.swift
//  MetovaTestKit
//
//  Created by Logan Gauthier on 6/28/17.
//  Copyright © 2017 Metova. All rights reserved.
//

import Foundation

/// Utility for producing descriptions for `String?` types without being wrapped in "Optional()".
///
/// - Parameter string: An optional String.
/// - Returns: The unwrapped value, if it exists. Otherwise, it returns an empty String.
func quotedString(_ string: String?) -> String {
    
    guard let string = string else {
        return "nil"
    }
    
    return "\"\(string)\""
}
