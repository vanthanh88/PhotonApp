//
//  NSURLExtentsions.swift
//  eKoTap
//
//  Created by Ulaai on 12/4/15.
//  Copyright © 2015 OHM. All rights reserved.
//

import Foundation


extension NSURL {
    
    func URLByAppendingQueryString(queryString: String) -> NSURL {
        if queryString.utf16.count == 0 {
            return self
        }
        
        var absoluteURLString = self.absoluteString
        
        if absoluteURLString.hasSuffix("?") {
            absoluteURLString = absoluteURLString[0 ..< absoluteURLString.utf16.count]
        }
        
        let URLString = absoluteURLString + (absoluteURLString.rangeOfString("?") != nil ? "&" : "?") + queryString
        
        return NSURL(string: URLString)!
    }
    
}
