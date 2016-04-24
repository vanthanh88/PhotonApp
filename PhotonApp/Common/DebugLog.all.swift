
//
//  DDFileReader+DebugLog.swift
//  DebugLog
//
//  Created by Yasuhiro Inami on 2014/06/26.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import Foundation

extension DDFileReader
{
    func readLogLine(index: Int) -> NSString!
    {
        var line: NSString!
        
        self.resetOffset()
        
        var lineNum = 0
        
        self.enumerateLinesUsingBlock { (currentLine, stop) in
            lineNum += 1
            if lineNum == index {
                line = currentLine
                stop = true
            }
        }
        
        let logFuncString = "LOG_OBJECT\\(.*?\\)" as NSString
        
        var range = line.rangeOfString(logFuncString as String, options: .RegularExpressionSearch)
        range.location += logFuncString.length-6
        range.length -= logFuncString.length-5
        
        line = line.substringWithRange(range).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return line
    }
}

//
//  DebugLog+ClassParsing.swift
//  DebugLog
//
//  Created by Yasuhiro Inami on 2014/06/26.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import Foundation

// Swift and Objective-C Class Parsing by @jpsim
// https://gist.github.com/jpsim/1b86d116808cb4e9bc30
extension DebugLog
{
    enum ClassType {
        case Swift, ObjectiveC
        
        func toString() -> String {
            switch self {
            case .Swift:
                return "Swift"
            case .ObjectiveC:
                return "Objective-C"
            }
        }
    }

    struct ParsedClass {
        let type: ClassType
        let name: String
        
        let mangledName: String?
        let moduleName: String?
    }

    static func _substr(str: String, range: Range<Int>) -> String {
        let startIndex = str.startIndex.advancedBy(range.startIndex)
        let endIndex = startIndex.advancedBy(range.endIndex)
        
        return str[Range(startIndex..<endIndex)]
    }

    static func parseClass(aClass: AnyClass) -> ParsedClass {
        // Swift mangling details found here: http://www.eswick.com/2014/06/inside-swift
        
        let originalName = NSStringFromClass(aClass)
        
        if !originalName.hasPrefix("_T") {
            // Not a Swift symbol
            return ParsedClass(type: ClassType.ObjectiveC,
                name: originalName,
                mangledName: nil,
                moduleName: nil)
        }
        
        let originalNameLength = originalName.utf16.count
        var cursor = 4
        var substring = _substr(originalName, range: cursor ..< originalNameLength-cursor)
        
        // Module
        let moduleLength = (substring as NSString).integerValue
        let moduleLengthLength = "\(moduleLength)".utf16.count
        let moduleName = _substr(substring, range: moduleLengthLength ..< moduleLength)
        
        // Update cursor and substring
        cursor += moduleLengthLength + moduleName.utf16.count
        substring = _substr(originalName, range: cursor ..< originalNameLength-cursor)
        
        // Class name
        let classLength = (substring as NSString).integerValue
        let classLengthLength = "\(classLength)".utf16.count
        let className = _substr(substring, range: classLengthLength ..< classLength)
        
        return ParsedClass(type: ClassType.Swift,
            name: className,
            mangledName: originalName,
            moduleName: moduleName)
    }
    
}

//
//  DebugLog+Printable.swift
//  DebugLog
//
//  Created by Yasuhiro Inami on 2014/06/22.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import Foundation
import CoreGraphics
import QuartzCore

//
// TODO: 
// Some C-structs (e.g. CGAffineTransform, CATransform3D) + Printable don't work well in Xcode6-beta2
//
extension CGAffineTransform : CustomStringConvertible, CustomDebugStringConvertible
{
    public var description: String
    {
//        return NSStringFromCGAffineTransform(self) // comment-out: requires UIKit
        return "[\(a), \(b);\n \(c), \(d);\n \(tx), \(ty)]"
    }
    
    public var debugDescription: String
    {
        return self.description
    }
}

extension CATransform3D : CustomStringConvertible, CustomDebugStringConvertible
{
    public var description: String
    {
        return "[\(m11) \(m12) \(m13) \(m14);\n \(m21) \(m22) \(m23) \(m24);\n \(m31) \(m32) \(m33) \(m34);\n \(m41) \(m42) \(m43) \(m44)]"
    }
    
    public var debugDescription: String
    {
        return self.description
    }
}

//
//  DebugLog.swift
//  DebugLog
//
//  Created by Yasuhiro Inami on 2014/06/22.
//  Copyright (c) 2014年 Inami Yasuhiro. All rights reserved.
//

import Foundation

struct DebugLog
{
    static let _lock = NSObject()
    
    static var printHandler: (Any!, String, String, Int) -> Void = { body, filename, functionName, line in
        
        if body == nil {
            print("[\(filename).\(functionName):\(line)]")    // print functionName
            return
        }
        
        if let body = body as? String {
            if body.characters.count == 0 {
                print("") // print break
                return
            }
        }
        
        print("[\(filename).\(functionName)[\(line)]] \(body)")
    }
    
    static func print(body: Any! = nil, filename: String = #file, functionName: String = #function, line: Int = #line)
    {
#if DEBUG
    
        objc_sync_enter(_lock)
    
        let fn = ((filename as NSString).lastPathComponent as NSString).stringByDeletingPathExtension
        self.printHandler(body, fn, functionName, line)
    
        objc_sync_exit(_lock)
    
#endif
    }
}

/// LOG() = prints #function
public func LOG(filename: String = #file, functionName: String = #function, line: Int = #line)
{
#if DEBUG
    
    DebugLog.print(nil, filename: filename, functionName: functionName, line: line)
    
#endif
}

/// LOG(...) = println
public func LOG(body: Any, filename: String = #file, functionName: String = #function, line: Int = #line)
{
#if DEBUG
    
    DebugLog.print(body, filename: filename, functionName: functionName, line: line)
    
#endif
}

/// LOG_OBJECT(myObject) = println("myObject = ...")
public func LOG_OBJECT(body: Any, filename: String = #file, functionName: String = #function, line: Int = #line)
{
#if DEBUG
    
    if let reader = DDFileReader(filePath: filename) {
        let logBody = "\(reader.readLogLine(line)) = \(body)"
        
        LOG(logBody, filename: filename, functionName: functionName, line: line)
    }
    
#endif
}

public func LOG_OBJECT(body: AnyClass, filename: String = #file, functionName: String = #function, line: Int = #line)
{
#if DEBUG
    
    _ = DDFileReader(filePath: filename)
    
    let classInfo: DebugLog.ParsedClass = DebugLog.parseClass(body)
    let classString = classInfo.moduleName != nil ? "\(classInfo.moduleName!).\(classInfo.name)" : "\(classInfo.name)"
    
    LOG_OBJECT(classString, filename: filename, functionName: functionName, line: line)
    
    // comment-out: requires method name demangling
//    LOG_OBJECT("\(class_getName(body))", filename: filename, functionName: functionName, line: line)
    
#endif
}


//
//  DDFileReader.swift
//  DDFileReader
//
//  Created by Yasuhiro Inami on 2014/06/22.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import Foundation

//
// Swift port of DDFileReader by Dave DeLong
//
// objective c - How to read data from NSFileHandle line by line? - Stack Overflow
// http://stackoverflow.com/a/3711079/666371
//
public class DDFileReader
{
    public var lineDelimiter = "\n"
    public var chunkSize = 128
    
    public let filePath: NSString
    
    private let _fileHandle: NSFileHandle!
    private let _totalFileLength: CUnsignedLongLong
    private var _currentOffset: CUnsignedLongLong = 0
    
    public init?(filePath: NSString)
    {
        self.filePath = filePath
        if let fileHandle = NSFileHandle(forReadingAtPath: filePath as String) {
            self._fileHandle = fileHandle
            self._totalFileLength = self._fileHandle.seekToEndOfFile()
        }
        else {
            self._fileHandle = nil
            self._totalFileLength = 0
            
            return nil
        }
    }
    
    deinit
    {
        self._fileHandle.closeFile()
    }
    
    public func readLine() -> NSString?
    {
        if self._currentOffset >= self._totalFileLength {
            return nil
        }
        
        self._fileHandle.seekToFileOffset(self._currentOffset)
        let newLineData = self.lineDelimiter.dataUsingEncoding(NSUTF8StringEncoding)
        let currentData = NSMutableData()
        var shouldReadMore = true
        
        autoreleasepool {
            
            while shouldReadMore {
                
                if self._currentOffset >= self._totalFileLength {
                    break
                }
                
                var chunk = self._fileHandle.readDataOfLength(self.chunkSize)
                
                let newLineRange = chunk.rangeOfData(newLineData!)
                
                if newLineRange.location != NSNotFound {
                    chunk = chunk.subdataWithRange(NSMakeRange(0, newLineRange.location+newLineData!.length))
                    shouldReadMore = false
                }
                currentData.appendData(chunk)
                
                self._currentOffset += CUnsignedLongLong(chunk.length)
                
            }
            
        }
        
        let line = NSString(data: currentData, encoding:NSUTF8StringEncoding)
        
        return line
    }
    
    public func readTrimmedLine() -> NSString?
    {
        let characterSet = NSCharacterSet(charactersInString: self.lineDelimiter)
        return self.readLine()?.stringByTrimmingCharactersInSet(characterSet)
    }
    
    public func enumerateLinesUsingBlock(closure: (line: NSString, stop: inout Bool) -> Void)
    {
        var line: NSString? = nil
        var stop = false
        while stop == false {
            line = self.readLine()
            if line == nil { break }
            
            closure(line: line!, stop: &stop)
        }
    }
    
    public func resetOffset()
    {
        self._currentOffset = 0
    }
}

extension NSData
{
    private func rangeOfData(dataToFind: NSData) -> NSRange
    {
        var searchIndex = 0
        var foundRange = NSRange(location: NSNotFound, length: dataToFind.length)
        
        for index in 0...length-1 {
            
            let bytes_ = UnsafeBufferPointer(start: UnsafePointer<CUnsignedChar>(self.bytes), count: self.length)
            let searchBytes_ = UnsafeBufferPointer(start: UnsafePointer<CUnsignedChar>(dataToFind.bytes), count: self.length)
            
            if bytes_[index] == searchBytes_[searchIndex] {
                if foundRange.location == NSNotFound {
                    foundRange.location = index
                }
                searchIndex += 1
                if searchIndex >= dataToFind.length {
                    return foundRange
                }
            }
            else {
                searchIndex = 0
                foundRange.location = NSNotFound
            }
            
        }
        return foundRange
    }
}
