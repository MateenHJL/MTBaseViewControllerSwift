//
//  BaseTableManager.swift
//  BaseUIManagerSwift
//
//  Created by Sumansoul on 2021/8/5.
//

import Foundation
 
open class BaseTableManager : NSObject {
    
    //didSelectRowAtIndexPath
    public typealias BaseTableManagerDidSelectRowAtIndexPathBlock = (BaseTableManager, UITableView? , IndexPath, BaseViewModel? , BaseViewModel?) -> Void
    
    //WillDisplayCellBlock
    public typealias BaseTableManagerWillDisplayCellBlock = (BaseTableManager, UITableView? , BaseTableViewCell?, IndexPath) -> Void
    
    public var didSelectedRowAtIndexPathBlock : BaseTableManagerDidSelectRowAtIndexPathBlock?
    public var willDisplayCellBlockBlock      : BaseTableManagerWillDisplayCellBlock?
    
    public var table : UITableView?
    
    public var viewModels : Array<BaseViewModel> = []
        
    public weak var target : AnyObject?
    
    //DidSelectRowAtIndexPath
    func BaseTableManagerDidSelectRow(tableViewManager : BaseTableManager , table : UITableView, indexPath : IndexPath , sectionViewModel : BaseViewModel, rowViewModel : BaseViewModel) -> Void{
        
    }
    
    func BaseTableManagerWillDisplayCellBlock(tableViewManager : BaseTableManager , table : UITableView, cell : BaseTableViewCell , indexPath : IndexPath) -> Void{
        
    }
    
    open func reloadDataFromViewModels(viewModels : Array<BaseViewModel>) -> Void{
        
    }
    
    public init(target : AnyObject) {
        self.target = target
    }
    
    public func reloadData() -> Void{
        
    }
}
