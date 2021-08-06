//
//  BaseTableViewCell.swift
//  BaseUIManagerSwift
//
//  Created by Sumansoul on 2021/7/23.
//

import Foundation
  
open class BaseTableViewCell : UITableViewCell {
     
    @objc private(set) var topLine : UIImageView = KitFactory.imageView()
    @objc private(set) var bottomLine : UIImageView = KitFactory.imageView()
    var baseViewModel : BaseViewModel?
    
    public override required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = UITableViewCellSelectionStyle.none
        setupLine()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLine() -> Void {
        self.topLine.isHidden = true
        self.contentView.addSubview(self.topLine)
        
        self.bottomLine.isHidden = true
        self.contentView.addSubview(self.bottomLine)
    }
    
    //controller should send message on it that reloadTableViewCell when data is Reload
    open func resetCellWithViewModel(viewModel : BaseViewModel) -> Void {
        self.baseViewModel = viewModel
        self.topLine.backgroundColor = viewModel.cellLineViewModel.topLineColor
        self.bottomLine.backgroundColor = viewModel.cellLineViewModel.bottomLineColor
    
        viewModel.unbindCellBlock?(viewModel, self)

        viewModel.bindCellBlock?(viewModel, self)
    }
    
    //calculated the height from model.
    public static func currentCellHeightWithViewModel (viewmodel : BaseViewModel) -> CGFloat {
        return 0.0
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let screenWidth  : CGFloat = self.contentView.bounds.size.width
        let screenHeight : CGFloat = self.contentView.bounds.size.height
        self.topLine.isHidden = !self.baseViewModel!.cellLineViewModel.showTopLine
        self.bottomLine.isHidden = !self.baseViewModel!.cellLineViewModel.showBottomLine
        
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
        
        if (self.topLine.isDescendant(of: self.contentView))
        {
            self.contentView.bringSubview(toFront: self.topLine)
        }
        
        if (self.bottomLine.isDescendant(of: self.contentView))
        {
            self.contentView.bringSubview(toFront: self.contentView)
        }
    }
     
    public override class func awakeFromNib() {
        
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        resetCellWithViewModel(viewModel: self.baseViewModel!)
    }

    deinit {
        print("\(self.classForCoder) has been dealloc")
        NotificationCenter.default.removeObserver(self)
        self.baseViewModel?.unbindCellBlock?(self.baseViewModel! , self)
    }
}
