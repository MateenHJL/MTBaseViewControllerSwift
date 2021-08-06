//
//  TestConfig.swift
//  BaseViewControllerSwift_Example
//
//  Created by Sumansoul on 2021/8/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import BaseViewControllerSwift
import BaseUIManagerSwift

class TestConfig : BaseViewControllerConfigDataSource {
    func defaultNavigationTitleFont() -> UIFont {
        return UIFont.systemAdjustFont(fontSize: 14)
    }
    
    func defaultNavigationTextColor() -> UIColor {
        return rgb(red: 249, green: 104, blue: 3)
    }
    
    func defaultStatusBarBackgroundColor() -> UIColor {
        return UIColor.clear
    }
    
    func defaultViewBackground() -> UIColor {
        return UIColor.blue
    }
    
    func defaultBackIcon() -> UIImage {
        return UIImage.init()
    }
    
    func tabbarNormalTextColor() -> UIColor {
        return rgb(red: 51, green: 51, blue: 51)
    }
    
    func tabbarNormalFont() -> UIFont {
        return UIFont.systemAdjustFont(fontSize: 12)
    }
    
    func tabbarSelectTextColor() -> UIColor {
        return rgb(red: 249, green: 104, blue: 87)
    }
    
    func tabbarSelectFont() -> UIFont {
        return UIFont.systemAdjustFont(fontSize: 12)
    }
    
    func superDeallocWithController(viewController: BaseViewController) {
        print("\(viewController.classForCoder) has been dealloc")
    }
    
    
}
