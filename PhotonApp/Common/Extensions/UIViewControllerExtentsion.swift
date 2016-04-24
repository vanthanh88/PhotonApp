//
//  ViewController.swift
//  eKoTap
//
//  Created by Ulaai on 11/30/15.
//  Copyright © 2015 OHM. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func canPerformSegue(id: String) -> Bool {
        let segues = self.valueForKey("storyboardSegueTemplates") as? [NSObject]
        let filtered = segues?.filter({ $0.valueForKey("identifier") as? String == id })
        return (filtered?.count > 0) ?? false
    }
    
    // Just so you dont have to check all the time
    func performSegue(id: String, sender: AnyObject?) -> Bool {
        if canPerformSegue(id) {
            self.performSegueWithIdentifier(id, sender: sender)
            return true
        }
        return false
    }
}