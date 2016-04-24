//
//  UIViewExtensions.swift
//  eKoTap
//
//  Created by Ulaai on 12/22/15.
//  Copyright © 2015 OHM. All rights reserved.
//

import UIKit

extension UIView {
    
    func imageFromView() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 1.0)
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
