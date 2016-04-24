//
//  ULNavigationViewController.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/6/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import UIKit

let useClosures = false

@objc @IBDesignable class ULNavigationViewController: UINavigationController {
    
    
    private var lbNetworkStatus: UILabel!
    var reachability: Reachability?
    
    @IBInspectable var isInitialController: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isInitialController {
            self.navigationBarHidden = true
            lbNetworkStatus = UILabel(frame: CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 30))
            lbNetworkStatus?.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.1)
            lbNetworkStatus.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
            lbNetworkStatus.textAlignment = .Center
            
            self.view.addSubview(lbNetworkStatus)
            lbNetworkStatus.hidden = true
//                    UIView.animateWithDuration(3, delay: 0, options: [.AllowAnimatedContent, .Repeat, .Autoreverse], animations: { () -> Void in
//                        self.lbNetworkStatus.frame.origin.y -= 500
//                        }, completion: nil)
            
            do {
                let reachability = try Reachability.reachabilityForInternetConnection()
                self.reachability = reachability
            } catch ReachabilityError.FailedToCreateWithAddress(let address) {
                lbNetworkStatus.textColor = UIColor.redColor()
                lbNetworkStatus.text = "Unable to create\nReachability with address:\n\(address)"
                return
            } catch {}
            
            if (useClosures) {
                reachability?.whenReachable = { reachability in
                    self.updateLabelColourWhenReachable(reachability)
                }
                reachability?.whenUnreachable = { reachability in
                    self.updateLabelColourWhenNotReachable(reachability)
                }
            } else {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ULNavigationViewController.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
            }
            
            do {
                try reachability?.startNotifier()
            } catch {
                lbNetworkStatus.textColor = UIColor.redColor()
                lbNetworkStatus.text = "Unable to start\nnotifier"
                return
            }
            
            // Initial reachability check
            if let reachability = reachability {
                if reachability.isReachable() {
                    updateLabelColourWhenReachable(reachability)
                } else {
                    updateLabelColourWhenNotReachable(reachability)
                }
            }
            
            
            // Do any additional setup after loading the view.
            
            LOG("Navigation controller view did load...")
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//         [UIColor colorWithRed:0.128 green:0.705 blue:0.099 alpha:1.000]
//        self.navigationBar.barTintColor = UIColor(red: 0.012, green: 0.702, blue: 0.820, alpha: 1.000)//UIColor(red: 0.128, green: 0.705, blue: 0.099, alpha: 1.000)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(18)]
        self.navigationBar.translucent = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Check network support
    
    deinit {
        
        reachability?.stopNotifier()
        
        if (!useClosures) {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        }
    }
    
    func updateLabelColourWhenReachable(reachability: Reachability) {
        if reachability.isReachableViaWiFi() {
            self.lbNetworkStatus.textColor = UIColor.greenColor()
        } else {
            self.lbNetworkStatus.textColor = UIColor.blueColor()
        }
        
        self.lbNetworkStatus.text = reachability.currentReachabilityString
        
        self.lbNetworkStatus.hidden = true
    }
    
    func updateLabelColourWhenNotReachable(reachability: Reachability) {
        self.lbNetworkStatus.textColor = UIColor.redColor()
        self.lbNetworkStatus.text = reachability.currentReachabilityString
        
        self.lbNetworkStatus.hidden = false
    }
    
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            updateLabelColourWhenReachable(reachability)
        } else {
            updateLabelColourWhenNotReachable(reachability)
        }
    }


}
