//
//  OneButtonCell.swift
//  BaseUIManagerSwift_Example
//
//  Created by Sumansoul on 2021/7/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import BaseUIManagerSwift

open class OneButtonCell: BaseTableViewCell {
    
    @objc var button : UIButton!;
    @objc var viewModel : OneButtonViewModel?
        
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupUIInterface()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIInterface() -> Void{
        
//        lazyInitAllSubViewUIWithAutolayoutEnable(autoLayoutEnable: true);
        
        self.backgroundColor = UIColor .blue
        
        self.button = KitFactory.button()
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.button!)
    }
    
    open override func resetCellWithViewModel(viewModel: BaseViewModel) {
        
        super.resetCellWithViewModel(viewModel: viewModel)
        
        if (viewModel is OneButtonViewModel)
        {
            self.viewModel = viewModel as? OneButtonViewModel
        }
        self.backgroundColor = viewModel.cellBackgroundColor
        self.button?.backgroundColor = self.viewModel!.buttonBackgroundColor
        self.button?.setTitleColor(self.viewModel!.textColor, for: UIControl.State.normal)
        self.button?.layer.cornerRadius = self.viewModel!.cornerRadius!
        self.button?.layer.borderWidth = self.viewModel!.boardWidth ?? 0;
        self.button?.layer.borderColor = self.viewModel!.boardColor?.cgColor
        self.button?.titleLabel?.font = self.viewModel!.font
        self.button?.setTitle(self.viewModel!.buttonTitle, for: UIControlState.normal)
        if (self.viewModel!.canTouch!)
        {
            self.button?.addTarget(self, action:#selector(respondsToButton(button:)), for: UIControl.Event.touchUpInside)
        }
        else
        {
            self.button?.removeTarget(self, action:#selector(OneButtonCell.respondsToButton(button:)), for: UIControl.Event.touchUpInside)
        }
        
        if (self.viewModel!.buttonWidth ?? 0 > 0)
        {
            self.button?.frame = CGRect.init(x: 0, y: 0, width: self.viewModel!.buttonWidth!, height: self.viewModel!.currentCellHeight)
            self.button?.center = CGPoint.init(x: self.viewModel!.superViewWdith! / 2, y: self.button!.center.y)
        }
        else
        {
            self.button?.frame = CGRect.init(x: self.viewModel!.space!, y: 0, width: self.viewModel!.superViewWdith! - self.viewModel!.space! * 2, height: self.viewModel!.currentCellHeight)
        }
    }
     
    @objc func respondsToButton(button : UIButton) -> Void {
        if (self.viewModel!.clickOneBlock != nil)
        {
            self.viewModel?.clickOneBlock(self, self.viewModel)
        }
    }
     
}
