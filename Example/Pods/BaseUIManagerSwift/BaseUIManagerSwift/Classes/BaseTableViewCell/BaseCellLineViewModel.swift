//
//  BaseCellLineViewModel.swift
//  BaseUIManagerSwift
//
//  Created by Sumansoul on 2021/7/23.
//

import Foundation


open class BaseCellLineViewModel {
    public var showTopLine           : Bool = false
    public var showBottomLine        : Bool = false
    var topLineEdgeInsets     : UIEdgeInsets = UIEdgeInsets.zero{
        didSet
        {
            self.showTopLine = true
        }
    }
    
    var bottomLineEdgeInsets  : UIEdgeInsets = UIEdgeInsets.zero{
        didSet
        {
            self.showBottomLine = true
        }
    }
    
    var topLineColor          : UIColor = rgba(red: 0, green: 0, blue: 0, alpha: 0.04)
    var bottomLineColor       : UIColor = rgba(red: 0, green: 0, blue: 0, alpha: 0.04)
    var topLineHeight         : CGFloat = 1
    var bottomLineHeight      : CGFloat = 1
}
