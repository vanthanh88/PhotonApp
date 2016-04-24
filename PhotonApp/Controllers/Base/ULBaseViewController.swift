//
//  ULBaseViewController.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/6/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import UIKit
import DTIToastCenter


class ULBaseViewController: UIViewController {

    
    //MARK: UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.configNavigationBar()
        self.configViewController()
        
        LOG("ULBaseViewController - ViewDidLoad")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
    
    //MARK: Should override method
    func configNavigationBar(){
        //do nothing here
        //Title image <logo Ulaai>
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
//        imageView.contentMode = .ScaleAspectFit
//        let image = UIImage(named: "ulaailogo.png")
//        imageView.image = image
//        self.navigationItem.titleView = imageView
    }
    func configViewController(){
        //do nothing
        
//        if !UIAccessibilityIsReduceTransparencyEnabled() {
//            self.view.backgroundColor = UIColor.clearColor()
//            
//            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//            let blurEffectView = UIVisualEffectView(effect: blurEffect)
//            //always fill the view
//            blurEffectView.frame = self.view.bounds
//            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//            
//            self.view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
//        } 
//        else {
//            self.view.backgroundColor = UIColor.blackColor()
//        }
    }
    
    
    func addRefreshControlToUITableView(tableView: UITableView) -> UIRefreshControl {
        let refreshCt = UIRefreshControl()
        
        tableView.addSubview(refreshCt)
        
        return refreshCt
    }
    
    ///outlet if need
    @IBAction func back(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

       
    func showToastWithMessage(message: String) {
        DTIToastCenter.defaultCenter.makeText(message)
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
