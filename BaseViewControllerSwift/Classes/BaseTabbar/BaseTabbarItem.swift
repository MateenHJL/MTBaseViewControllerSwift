//
//  BaseTabbarItem.swift
//  BaseViewControllerSwift
//
//  Created by Sumansoul on 2021/8/3.
//

import Foundation

open class BaseTabbarItem {
    public var classInstance  : BaseViewController?
    public var normalImage    : UIImage?
    public var selectedImage  : UIImage?
    public var normalTitle    : String?
    public var tabbarItemType : Int?
    public var badgeValue     : String?
    
    public init() {
        
    }
}
