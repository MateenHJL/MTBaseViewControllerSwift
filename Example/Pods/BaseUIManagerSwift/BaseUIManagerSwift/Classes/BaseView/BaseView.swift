//
//  BaseView.swift
//  BaseUIManagerSwift
//
//  Created by Sumansoul on 2021/7/23.
//

import Foundation
import pop

public enum BaeViewAnimationType {
    case fade           //fade animation
    case point          //move position animation
    case size           //scale animation
    case rect           //move-scale animation
}

open class BaseView : UIView{
    
    private(set) var topLine : UIImageView = KitFactory.imageView()
    private(set) var bottomLine : UIImageView = KitFactory.imageView()
    var baseViewModel : BaseViewModel?
    
    public var animationType : BaeViewAnimationType?
    
    public var animationDidEndBlock : tAnimationDidEndBlock?
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.animationType = BaeViewAnimationType.fade
        
        setupLine()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLine() -> Void {
        self.topLine.isHidden = true
        self.addSubview(self.topLine)
        
        self.bottomLine.isHidden = true
        self.addSubview(self.bottomLine)
    }
    
    open func refreshViewAttributedAnimationWithCompletedBlock(block : @escaping tAnimationDidEndBlock) -> Void {
        self.animationDidEndBlock = block
        
        self.hiddenViewWithAnimation(type: self.animationType!)
    }
    
    func hiddenViewWithAnimation(type : BaeViewAnimationType) -> Void {
        switch type
        {
            case BaeViewAnimationType.fade:
                self.animationWithFadeCompletedUsing { (animation : POPAnimation?, isFinished : Bool) in
                    self.animationDidEndBlock? (animation , isFinished)
                }
            case BaeViewAnimationType.point:
                self.animationWithPointCompletedUsing { (animation : POPAnimation?, isFinished : Bool) in
                    self.animationDidEndBlock? (animation , isFinished)
                }
            case BaeViewAnimationType.rect:
                self.animationWithSizeCompletedUsing { (animation : POPAnimation?, isFinished : Bool) in
                    self.animationDidEndBlock? (animation , isFinished)
                }
            case BaeViewAnimationType.size:
                self.animationWithRectCompletedUsing { (animation : POPAnimation?, isFinished : Bool) in
                    self.animationDidEndBlock? (animation , isFinished)
                }
            
        }
    }
    
    open func resetViewWithViewModel(viewModel : BaseViewModel) -> Void {
        self.baseViewModel = viewModel
        
        self.topLine.backgroundColor = viewModel.cellLineViewModel.topLineColor
        self.bottomLine.backgroundColor = viewModel.cellLineViewModel.bottomLineColor
        
        viewModel.unbindViewBlock?(viewModel , self)
        viewModel.bindViewBlock?(viewModel , self)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if (self.baseViewModel != nil)
        {
            let screenWidth  : CGFloat = self.bounds.size.width
            let screenHeight : CGFloat = self.bounds.size.height
            self.topLine.isHidden = !(self.baseViewModel?.cellLineViewModel.showTopLine)!
            self.bottomLine.isHidden = !(self.baseViewModel?.cellLineViewModel.showBottomLine)!
            
            if (!self.topLine.isHidden)
            {
                let topInset = self.baseViewModel!.cellLineViewModel.topLineEdgeInsets
                self.topLine.frame = CGRect.init(x: topInset.left, y: 0, width: screenWidth - topInset.left - topInset.right, height: self.baseViewModel!.cellLineViewModel.topLineHeight)
            }
            
            if (!self.bottomLine.isHidden)
            {
                let bottomInset = self.baseViewModel!.cellLineViewModel.bottomLineEdgeInsets
                self.topLine.frame = CGRect.init(x: bottomInset.left, y: screenHeight - self.baseViewModel!.cellLineViewModel.bottomLineHeight, width: screenWidth - bottomInset.left - bottomInset.right, height: self.baseViewModel!.cellLineViewModel.bottomLineHeight)
            }
            
            if (self.topLine.isDescendant(of: self))
            {
                self.bringSubview(toFront: self.topLine)
            }
            
            if (self.bottomLine.isDescendant(of: self))
            {
                self.bringSubview(toFront: self)
            }
        }
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        resetViewWithViewModel(viewModel: self.baseViewModel!)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.baseViewModel?.unbindViewBlock?(self.baseViewModel!, self)
        print("\(self.classForCoder) has been dealloc")
    }
}
