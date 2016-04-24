//
//  ZoomEffectSegue.swift
//  eKoTap
//
//  Created by Ulaai on 12/22/15.
//  Copyright © 2015 OHM. All rights reserved.
//

import UIKit

class ZoomEffectSegue: UIStoryboardSegue {
    
    override func perform() {
        self.sourceViewController.presentViewController(self.destinationViewController, animated: false, completion: nil)
    }

}
