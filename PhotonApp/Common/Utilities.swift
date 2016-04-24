//
//  Utilities.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/6/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import UIKit
import AudioToolbox

class Utilities: NSObject {
    
    
    class func colorListDefault() -> Array<UIColor> {
        return [UIColor(red: 0.918, green: 0.012, blue: 0.184, alpha: 1.000),
                UIColor(red: 1.000, green: 0.969, blue: 0.616, alpha: 1.000),
                UIColor(red: 0.929, green: 0.349, blue: 0.000, alpha: 1.000),
                UIColor(red: 0.827, green: 0.322, blue: 0.008, alpha: 1.000),
                UIColor(red: 0.616, green: 0.255, blue: 0.024, alpha: 1.000),
                UIColor(red: 0.541, green: 0.596, blue: 0.635, alpha: 1.000),
                UIColor(red: 0.722, green: 0.718, blue: 0.733, alpha: 1.000),
                UIColor(red: 0.812, green: 0.004, blue: 0.561, alpha: 1.000),
                UIColor(red: 0.498, green: 0.059, blue: 0.569, alpha: 1.000),
                UIColor(red: 0.114, green: 0.000, blue: 0.357, alpha: 1.000),
                UIColor(red: 0.349, green: 0.165, blue: 0.039, alpha: 1.000),
                UIColor(red: 0.157, green: 0.000, blue: 0.000, alpha: 1.000),
                UIColor(red: 0.765, green: 0.729, blue: 0.859, alpha: 1.000),
                UIColor(red: 0.239, green: 0.545, blue: 0.792, alpha: 1.000),
                UIColor(red: 0.008, green: 0.392, blue: 0.698, alpha: 1.000),
                UIColor(red: 0.004, green: 0.263, blue: 0.510, alpha: 1.000),
                UIColor(red: 0.408, green: 0.804, blue: 0.961, alpha: 1.000),
                UIColor(red: 0.016, green: 0.682, blue: 0.937, alpha: 1.000),
                UIColor(red: 0.008, green: 0.345, blue: 0.667, alpha: 1.000),
                UIColor(red: 0.208, green: 0.122, blue: 0.573, alpha: 1.000),
                UIColor(red: 0.039, green: 0.737, blue: 0.831, alpha: 1.000),
                UIColor(red: 0.345, green: 0.745, blue: 0.616, alpha: 1.000),
                UIColor(red: 0.000, green: 0.639, blue: 0.337, alpha: 1.000),
                UIColor(red: 0.004, green: 0.580, blue: 0.612, alpha: 1.000),
                UIColor(red: 0.812, green: 0.851, blue: 0.000, alpha: 1.000),
                UIColor(red: 0.631, green: 0.784, blue: 0.000, alpha: 1.000),
                UIColor(red: 0.000, green: 0.671, blue: 0.220, alpha: 1.000),
                UIColor(red: 0.000, green: 0.451, blue: 0.141, alpha: 1.000),
                UIColor(red: 0.004, green: 0.212, blue: 0.024, alpha: 1.000),
                UIColor(red: 0.953, green: 0.725, blue: 0.831, alpha: 1.000)]
    }
    
    
    
    /**
     Get viewcontroller from storyboard id
     
     - parameter storyBoardID: storyboard id
     
     - returns: a view controller from story board id
     */
    class func viewControllerFromStoryBoardID(storyBoardID: StoryBoardID) -> UIViewController?{
        var resultViewController: UIViewController?
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        resultViewController = mainStoryboard.instantiateViewControllerWithIdentifier(storyBoardID.rawValue)
        
        return resultViewController
        
    }
    
    /**
     get document app folder
     
     - returns: document app folder
     */
    class func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDir = paths.firstObject as! String

        return documentsDir
    }
    
    
    class func makePhoneVibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    //MARK: System version support
    /**
     get device system version
     
     - returns: device system version
     */
    class func systemVersion() -> String {
        let sysV = UIDevice.currentDevice().systemVersion
        return sysV
    }
    /**
     System version
     
     - parameter version: version ex: 8.0
     
     - returns: true/false
     */
    class func systemVersionEqualTo(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version,
            options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
    }
    
    /**
     System version
     
     - parameter version: version ex: 8.0
     
     - returns: true/false
     */
    
    class func systemVersionGreaterThan(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version as String,
            options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
    }
    /**
     System version
     
     - parameter version: version ex: 8.0
     
     - returns: true/false
     */
    
    class func systemVersionGreaterThanOrEqualTo(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version as String,
            options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
    }
    /**
     System version
     
     - parameter version: version ex: 8.0
     
     - returns: true/false
     */
    class func systemVersionLessThan(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version as String,
            options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
    }
    
    /**
     System version
     
     - parameter version: version ex: 8.0
     
     - returns: true/false
     */
    class func systemVersionLessThanOrEqualTo(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version as String,
            options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
    }
    /**
     get Device identifier
     
     - returns: string value
     */
    class func deviceIdentifier() -> String {
        return UIDevice.currentDevice().identifierForVendor!.UUIDString
    }
    
    
    class func formatRewardWithRewardNumber(number: Int) -> String {
        if number <= 0 { return "" }
        return (number == 1) ? "1 Reward" : "\(number) Rewards"
    }
    class func formatRewardNumber(number: Int) -> String {
        if number >= 0 { return "\(number) Reward"}
        return "n/a"
    
    }
}
