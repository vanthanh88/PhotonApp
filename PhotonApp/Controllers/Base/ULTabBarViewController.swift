//
//  ULTabBarViewController.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/6/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import UIKit

class ULTabBarViewController: UITabBarController {

    
    override func awakeFromNib() {
       
        
//        UITabBar.appearance().tintColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for tabBarItem in self.tabBar.items! {
            tabBarItem.image = tabBarItem.image?.imageWithRenderingMode(.AlwaysOriginal)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
