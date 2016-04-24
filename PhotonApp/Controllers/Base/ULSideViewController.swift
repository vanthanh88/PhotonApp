//
//  ULSideViewController.swift
//  eKoTap
//
//  Created by Chau Bui Luong on 12/1/15.
//  Copyright © 2015 OHM. All rights reserved.
//

import UIKit

class ULSideViewController: SSASideMenu {
    
    
    var statusBarHidden: Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.performSegueWithIdentifier(StoryBoardSegueIdentifier.RegisterController.rawValue, sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepareForSegue(segue, sender: sender)
       
        
    }
    
  
    override func prefersStatusBarHidden() -> Bool {
        LOG(statusBarHidden)
        return statusBarHidden
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}
