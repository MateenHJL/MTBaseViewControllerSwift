//
//  VirtualLineViewModel.swift
//  BaseUIManagerSwift_Example
//
//  Created by Sumansoul on 2021/7/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import BaseUIManagerSwift

open class VirtualLineViewModel: BaseViewModel {
    @objc dynamic var title : String?
    
    typealias clickViewBlock = (VirtualLineCell, VirtualLineViewModel?) -> Void
    var clickViewBlock : clickViewBlock!
     
}
