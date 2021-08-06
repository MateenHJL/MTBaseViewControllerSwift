//
//  VirtualLineCell.swift
//  BaseUIManagerSwift_Example
//
//  Created by Sumansoul on 2021/7/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import BaseUIManagerSwift

open class VirtualLineCell: BaseTableViewCell {
    
    var label : UILabel!
    var viewModel : VirtualLineViewModel!
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUIInterface()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIInterface() -> Void{
        
        self.backgroundColor = UIColor.green
        
        self.label = KitFactory.label()
        self.label.backgroundColor = UIColor.red
        self.label.isUserInteractionEnabled = true
        self.label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(respondsToLabel(sender:))))
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.textAlignment = NSTextAlignment.center
        self.label.font = UIFont.systemFont(ofSize: 26)
        self.label.textColor = rgb(red: 241, green: 237 , blue: 234)
        self.contentView.addSubview(self.label)
        
        self.contentView.addConstraint(NSLayoutConstraint.init(item: self.label, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[_label]-50-|", options: .directionLeadingToTrailing, metrics: [:], views: ["_label" : label]))
    }
    
    open override func resetCellWithViewModel(viewModel: BaseViewModel) {
        
        super.resetCellWithViewModel(viewModel: viewModel)
        
        if (viewModel is VirtualLineViewModel)
        {
            self.viewModel = viewModel as? VirtualLineViewModel
        }
        self.label?.text = self.viewModel.title
    }
    
    @objc func respondsToLabel (sender : Any){
        self.viewModel.clickViewBlock?(self, self.viewModel)
    }
     
}
