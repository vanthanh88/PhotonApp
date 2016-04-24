//
//  MainBackgroupView.swift
//  PhotonApp
//
//  Created by Ulaai on 4/24/16.
//  Copyright © 2016 Photon. All rights reserved.
//

import UIKit

class MainBackgroupView: UIView {
    
    @IBInspectable var topFillColor: UIColor = UIColor(red: 0.762, green: 0.654, blue: 0.994, alpha: 1.000)
    @IBInspectable var bottomFillColor: UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.100)
    
    
    @IBInspectable var type: Int = 1
    
    
    override func drawRect(rect: CGRect) {
        
        //// path- Drawing
        let pathPath = UIBezierPath(rect: rect)
        topFillColor.setFill()
        pathPath.fill()
        
        let shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(rect.width, rect.height/4))
        shapePath.addLineToPoint(CGPointMake(0, 3 * rect.height/4))
        shapePath.addLineToPoint(CGPointMake(0, rect.height))
        shapePath.addLineToPoint(CGPointMake(rect.width, rect.height))
        shapePath.addLineToPoint(CGPointMake(rect.width, rect.height/4))
        shapePath.closePath()
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = true;
        
        bottomFillColor.setFill()
        shapePath.fill()

        
    }
    

}
