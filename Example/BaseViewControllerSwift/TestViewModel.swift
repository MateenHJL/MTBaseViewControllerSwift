//
//  TestViewModel.swift
//  BaseUIManagerSwift_Example
//
//  Created by Sumansoul on 2021/8/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

import BaseUIManagerSwift

open class TestViewModel : BaseViewModel {
    @objc dynamic var title : String?
    
    typealias clickViewBlock = (TestView, TestViewModel?) -> Void
    var clickViewBlock : clickViewBlock!
    
}
