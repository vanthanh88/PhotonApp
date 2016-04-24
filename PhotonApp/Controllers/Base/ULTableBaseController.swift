//
//  ULTableBaseController.swift
//  eKoTap
//
//  Created by Ulaai on 29/02/2016.
//  Copyright © 2016 OHM. All rights reserved.
//

import UIKit
import DTIToastCenter

class ULTableBaseController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configViewController()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return super.numberOfSectionsInTableView(tableView)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
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
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
