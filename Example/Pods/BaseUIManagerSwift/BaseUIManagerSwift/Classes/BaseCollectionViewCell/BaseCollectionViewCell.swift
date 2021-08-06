//
//  BaseCollectionViewCell.swift
//  BaseUIManagerSwift
//
//  Created by Sumansoul on 2021/7/23.
//

import Foundation

public class BaseCollectionViewCell: UICollectionViewCell {
    var delegate : Any?
    
    private(set) var topLine : UIImageView = KitFactory.imageView()
    private(set) var bottomLine : UIImageView = KitFactory.imageView()
    var baseViewModel : BaseViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setupLine()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLine() -> Void {
        self.topLine.isHidden = true
        self.contentView.addSubview(self.topLine)
        
        self.bottomLine.isHidden = true
        self.contentView.addSubview(self.bottomLine)
    }
    
    //controller should send message on it that reloadTableViewCell when data is Reload
    func resetCellWithViewModel(viewModel : BaseViewModel) -> Void {
        self.baseViewModel = viewModel
        self.topLine.backgroundColor = viewModel.cellLineViewModel.topLineColor
        self.bottomLine.backgroundColor = viewModel.cellLineViewModel.bottomLineColor
    
        viewModel.unbindCollectionViewCellBlock?(viewModel, self)
        
        viewModel.bindCollectionViewCellBlock?(viewModel, self)
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
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        resetCellWithViewModel(viewModel: self.baseViewModel!)
    }
     
    deinit {
        print("\(self.classForCoder) has been dealloc")
        NotificationCenter.default.removeObserver(self)
        self.baseViewModel?.unbindCollectionViewCellBlock?(self.baseViewModel! , self)
    }
}
