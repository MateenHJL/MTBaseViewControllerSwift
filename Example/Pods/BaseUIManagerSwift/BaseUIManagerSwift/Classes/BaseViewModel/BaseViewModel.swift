//
//  BaseViewModel.swift
//  BaseUIManagerSwift
//
//  Created by Sumansoul on 2021/7/23.
//

import Foundation

open class BaseViewModel : NSObject {
    
    public typealias tBindCellBlock = (BaseViewModel, BaseTableViewCell) -> Void
    public typealias tUnbindCellBlock = (BaseViewModel, BaseTableViewCell) -> Void
    public var bindCellBlock : tBindCellBlock?
    public var unbindCellBlock : tUnbindCellBlock?
    
    public typealias tBindViewBlock = (BaseViewModel, BaseView) -> Void
    public typealias tUnbindViewBlock = (BaseViewModel, BaseView) -> Void
    public var bindViewBlock : tBindViewBlock?
    public var unbindViewBlock : tUnbindViewBlock?
    
    public typealias tBindCollectionViewCellBlock = (BaseViewModel, BaseCollectionViewCell) -> Void
    public typealias tUnbindCollectionViewCellBlock = (BaseViewModel, BaseCollectionViewCell) -> Void
    public var bindCollectionViewCellBlock : tBindCollectionViewCellBlock?
    public var unbindCollectionViewCellBlock : tUnbindCollectionViewCellBlock?
    
    public typealias tObserverKeyPathChangedBlock<ViewModelType, ObjectType> = (ViewModelType, String, ObjectType) -> Void
    public var observerKeyPathChangedBlock : tObserverKeyPathChangedBlock<BaseViewModel, Any>?

    //the line in cell ViewModel,you can set up the line attributed,such as lineColor、lineHeight、position of line
    public var cellLineViewModel : BaseCellLineViewModel = BaseCellLineViewModel.init()
    
    //the origin dataModel
    public var dataModel : Any?
    
    //the backgroundColor of tableviewCell.
    public var cellBackgroundColor : UIColor?
    
    //the className of tableviewCell.
    public var cellClass : BaseTableViewCell.Type?{
        didSet
        {
            self.cellIndentifier = String(describing: cellClass!)
        }
    }
    
    //the height of tableviewcellHeight,default is define cellDefaultHeight(44).
    public var currentCellHeight : CGFloat = 0.0
    
    //cell indetifier
    public private(set) var cellIndentifier : String? = ""
    
    //cellType
    public var cellType : Int?
    
    //superViewModel
    public var superViewModel : BaseViewModel?
    
    //subviewModel
    public var subViewModelArray : Array<BaseViewModel> = []
    
    public override init() {
        self.cellLineViewModel = BaseCellLineViewModel.init()
        self.currentCellHeight = 0.0
        self.cellIndentifier = ""
        self.cellBackgroundColor = UIColor.clear
    }
     
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        observerKeyPathChangedBlock?(self , keyPath!, object!);
    }
    
    deinit {
        print("\(self.classForCoder) has been dealloc")
    }
}
