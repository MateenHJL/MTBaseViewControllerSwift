//
//  OneButtonViewModel.swift
//  BaseUIManagerSwift_Example
//
//  Created by Sumansoul on 2021/7/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import BaseUIManagerSwift

open class OneButtonViewModel: BaseViewModel {
    var buttonTitle : String?
    var space : CGFloat?
    var buttonBackgroundColor : UIColor?
    var buttonWidth : CGFloat?
    var cornerRadius : CGFloat?
    var textColor : UIColor?
    var boardWidth : CGFloat?
    var boardColor : UIColor?
    var font : UIFont?
    var canTouch : Bool?
    var hasAnimation : Bool?
    var isGradientStyle : Bool?
    var colors : Array<UIColor>?
    var superViewWdith : CGFloat?
    
    typealias clickOneButtonBlock = (OneButtonCell, OneButtonViewModel?) -> Void
    var clickOneBlock : clickOneButtonBlock!
     
}
