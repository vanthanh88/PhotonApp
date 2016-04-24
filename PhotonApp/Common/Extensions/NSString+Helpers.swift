//
//  NSString+Helpers.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/16/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import UIKit

extension String {

    func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
                return from ..< to
        }
        return nil
    }
    
    func NSRangeFromRange(range : Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.startIndex, within: utf16view)
        let to = String.UTF16View.Index(range.endIndex, within: utf16view)
        return NSMakeRange(utf16view.startIndex.distanceTo(from), from.distanceTo(to))
    }
    
    
    func md5() -> String {
        let data = (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))
        let resultBytes = UnsafeMutablePointer<CUnsignedChar>(result!.mutableBytes)
        CC_MD5(data!.bytes, CC_LONG(data!.length), resultBytes)
        
        let a = UnsafeBufferPointer<CUnsignedChar>(start: resultBytes, count: result!.length)
        let hash = NSMutableString()
        
        for i in a {
            hash.appendFormat("%02x", i)
        }
        let r = hash as String
        return r
    }
    
    /**
     Encode a String to Base64
     
     :returns:
     */
    func toBase64() -> String {
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
    }
    
    
    static func stringWithURLEncoding(string: String) -> String {
        let tempString = String(format: string)
        let re = CFURLCreateStringByAddingPercentEscapes(nil, tempString, nil, "!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))
        
        return re as String
    }
    
    internal func indexOf(sub: String) -> Int? {
        var pos: Int?
        
        if let range = self.rangeOfString(sub) {
            if !range.isEmpty {
                pos = self.startIndex.distanceTo(range.startIndex)
            }
        }
        
        return pos
    }
    
    internal subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = startIndex.advancedBy(r.endIndex - r.startIndex)
            
            return self[Range(startIndex ..< endIndex)]
        }
    }
    
    func urlEncodedStringWithEncoding(encoding: NSStringEncoding) -> String {
        let charactersToBeEscaped = ":/?&=;+!@#$()',*" as CFStringRef
        let charactersToLeaveUnescaped = "[]." as CFStringRef
        
        let str = self as NSString
        
        let result = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, str as CFString, charactersToLeaveUnescaped, charactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding)) as NSString
        
        return result as String
    }
    
    func parametersFromQueryString() -> Dictionary<String, String> {
        var parameters = Dictionary<String, String>()
        
        let scanner = NSScanner(string: self)
        
        var key: NSString?
        var value: NSString?
        
        while !scanner.atEnd {
            key = nil
            scanner.scanUpToString("=", intoString: &key)
            scanner.scanString("=", intoString: nil)
            
            value = nil
            scanner.scanUpToString("&", intoString: &value)
            scanner.scanString("&", intoString: nil)
            
            if key != nil && value != nil {
                parameters.updateValue(value! as String, forKey: key! as String)
            }
        }
        
        return parameters
    }
    
    func SHA1DigestWithKey(key: String) -> NSData {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<Void>.alloc(digestLen)
        
        let keyStr = key.cStringUsingEncoding(NSUTF8StringEncoding)!
        let keyLen = key.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), keyStr, keyLen, str!, strLen, result)
        
        return NSData(bytes: result, length: digestLen)
    }

    func isUrl() -> Bool {
        
        let urlRegEx = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        
        return predicate.evaluateWithObject(self)
    }
    
    
    
    
    
    var lastPathComponent: String {
        
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        
        get {
            
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        
        get {
            
            return (self as NSString).stringByDeletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).stringByDeletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathExtension(ext)
    }
    


}
