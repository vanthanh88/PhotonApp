//
//  Constants.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/6/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import UIKit


let itemsLoadPerPage = 30

let ENABLE_TAB_FUNCTION = false


let REGEX_USER_NAME_LIMIT   = "^.{6,50}$"
let USERNAME_MIN_LENGTH     = 6
let REGEX_USER_NAME         = "^[a-z0-9_-]{6,50}$"
let REGEX_EMAIL             = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
let REGEX_PASSWORD_LIMIT    = "^.{6,50}$"
let REGEX_PASSWORD          = "[A-Za-z0-9]{6,50}"
let REGEX_PHONE_DEFAULT     = "[0-9]{9,15}$"
let REGEX_IDENTITYCARD      = "^[0-9]{6,45}$"



let PHOTON_BUTTON_COLOR1 = UIColor(hex6: 0xFF2E63)



public enum StoryBoardSegueIdentifier: String {
    case LeftViewController             = "LeftViewControllerIdentifier"
    case RegisterController             = "RegisterControllerIdentifier"
    case VerifyPhoneNumberController    = "VerifyPhoneNumberControllerIdentifier"
}


public enum StoryBoardID: String {
    case LeftViewController         = "LeftViewControllerIdentifier"
    case MainViewController         = "MainViewControllerIdentifier"
}



//MARK: System support
enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6_OR_MORE          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH >= 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}