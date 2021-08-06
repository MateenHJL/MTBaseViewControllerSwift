//
//  BaseViewControllerConfigManager.swift
//  BaseViewControllerSwift
//
//  Created by Sumansoul on 2021/8/4.
//

import Foundation

@objc public protocol BaseViewControllerConfigDataSource {
    func defaultNavigationTitleFont() -> UIFont

    func defaultNavigationTextColor() -> UIColor

    func defaultStatusBarBackgroundColor() -> UIColor

    func defaultViewBackground() -> UIColor
    
    func defaultBackIcon() -> UIImage
    
    func tabbarNormalTextColor() -> UIColor
    
    func tabbarNormalFont() -> UIFont
    
    func tabbarSelectTextColor() -> UIColor
    
    func tabbarSelectFont() -> UIFont
    
    func superDeallocWithController(viewController : BaseViewController) -> Void
}

open class BaseViewControllerConfigManager {
    
    public var config : BaseViewControllerConfigDataSource!
    
    static let manager = BaseViewControllerConfigManager()
    
    //init with SingleTon
    public static func shareViewControllerConfig () -> BaseViewControllerConfigManager{
        return manager;
    }
    
    public func setupHttpEngineWithConfig(config : BaseViewControllerConfigDataSource) -> Void {
        self.config = config
    }
    
    init() {
        
    }

}
