//
//  UIFontExtentstion.swift
//  ekoTap
//
//  Created by Ulaai on 17/03/2016.
//  Copyright © 2016 eKoTap. All rights reserved.
//

import UIKit

extension UIFont {

    class func robotoFontOfSize(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Roboto", size: fontSize) ?? UIFont.systemFontOfSize(10)
    }
    class func boldRobotoFontOfSize(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: fontSize) ?? UIFont.systemFontOfSize(10)
    }
    
}
