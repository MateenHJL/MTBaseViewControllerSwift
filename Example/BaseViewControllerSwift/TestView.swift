//
//  TestView.swift
//  BaseUIManagerSwift_Example
//
//  Created by Sumansoul on 2021/8/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BaseUIManagerSwift

open class TestView: BaseView {

    var label : UILabel!
    var viewModel : TestViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.label = KitFactory.label()
        self.label.isUserInteractionEnabled = true
        self.label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(respondsToLabel(sender:))))
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.label)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[_label]|", options: .directionLeadingToTrailing, metrics: [:], views: ["_label" : label]))
        self.addConstraint(NSLayoutConstraint.init(item: self.label, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0))
    }
    
    open override func resetViewWithViewModel(viewModel: BaseViewModel) {
        
        super.resetViewWithViewModel(viewModel: viewModel);
        
        if (viewModel is TestViewModel)
        {
            self.viewModel = (viewModel as! TestViewModel)
        }
        self.label.text = self.viewModel.title
    }
    
    @objc func respondsToLabel (sender : UITapGestureRecognizer){
        self.viewModel.clickViewBlock?(self , self.viewModel)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
