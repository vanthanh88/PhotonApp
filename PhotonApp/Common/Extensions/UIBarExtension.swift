//
//  UIBarExtension.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/7/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import Foundation
import UIKit


private var kBackgroundViewKey = "kBackgroundViewKey"
private var kStatusBarMaskKey  = "kStatusBarMaskKey"

extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = false
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            LOG("subview \(subview)")
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
    
    
    public func df_setStatusBarMaskColor(color: UIColor) {
        if statusBarMask == nil {
            statusBarMask = UIView(frame: CGRect(x: 0, y: -20, width: ScreenSize.SCREEN_MAX_LENGTH, height: 20))
            statusBarMask?.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
            if let tempBackgroundView = backgroundView {
                insertSubview(statusBarMask!, aboveSubview: tempBackgroundView)
            }else {
                insertSubview(statusBarMask!, atIndex: 0)
            }
        }
        statusBarMask?.backgroundColor = color
    }
    public func df_setBackgroundColor(color: UIColor) {
        if backgroundView == nil {
            setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            shadowImage = UIImage()
            backgroundView = UIView(frame: CGRect(x: 0, y: -20, width: ScreenSize.SCREEN_MAX_LENGTH, height: 64))
            backgroundView?.userInteractionEnabled = false
            backgroundView?.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
            insertSubview(backgroundView!, atIndex: 0)
        }
        backgroundView?.backgroundColor = color
        
    }
    
    public func df_reset() {
        setBackgroundImage(nil, forBarMetrics: .Default)
        shadowImage = nil
        
        backgroundView?.removeFromSuperview()
        backgroundView = nil
    }
    
    // MARK: Properties
    private var backgroundView:UIView? {
        get {
            return objc_getAssociatedObject(self, &kBackgroundViewKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &kBackgroundViewKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            
        }
    }
    private var statusBarMask:UIView? {
        get {
            return objc_getAssociatedObject(self, &kStatusBarMaskKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &kStatusBarMaskKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}

extension UIToolbar {
    
    func hideHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(self)
        navigationBarImageView!.hidden = true
    }
    
    func showHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(self)
        navigationBarImageView!.hidden = false
    }
    
    private func hairlineImageViewInToolbar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInToolbar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}