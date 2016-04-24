//
//  VerifyController.swift
//  PhotonApp
//
//  Created by Ulaai on 4/24/16.
//  Copyright © 2016 Photon. All rights reserved.
//

import UIKit

class VerifyController: ULBaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tfVerifyCode: UITextField!
    
    @IBOutlet weak var bottonPaddingConstraint: NSLayoutConstraint!
    private var bottomPadding: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegisterController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegisterController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
        bottomPadding = bottonPaddingConstraint.constant
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func keyboardWillShow(sender: NSNotification) {
        // 1
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        // 2
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        
        self.bottonPaddingConstraint.constant  = keyboardSize.height
        
        
        UIView .animateWithDuration(0.25) {
            self.containerView.setNeedsLayout()
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.bottonPaddingConstraint.constant = bottomPadding
        
        UIView .animateWithDuration(0.25) {
            self.containerView.setNeedsLayout()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    @IBAction func didSuperViewTapped(sender: AnyObject) {
        
        tfVerifyCode.resignFirstResponder()
        
    }

    @IBAction func verify(sender: AnyObject) {
        
        
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
