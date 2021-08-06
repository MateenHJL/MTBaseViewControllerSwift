//
//  GroupViewController.swift
//  BaseUIManagerSwift_Example
//
//  Created by Sumansoul on 2021/8/6.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BaseUIManagerSwift
import BaseViewControllerSwift

class GroupViewController: BaseViewController {

    var manager : GroupTableViewManager?
    
    override func viewDidLoad() {
        self.manager = GroupTableViewManager.init(target: self)
        self.manager?.table?.frame = CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height - 100)
        self.manager?.didSelectedRowAtIndexPathBlock? = {(manager : BaseTableManager, table : UITableView? , indexPath : IndexPath,  sectionViewModel : BaseViewModel? , rowViewModel : BaseViewModel?) -> Void in
            
        }
        self.manager?.willDisplayCellBlockBlock? = {(manager : BaseTableManager, table : UITableView? , cell : BaseTableViewCell?, indexPath : IndexPath) in
            
        }
        if let tmpTable = self.manager?.table
        {
            self.view.addSubview(tmpTable)
        }
        
        var viewModels : Array<BaseViewModel> = []
        
        for _ in 0...3 {
            let groupViewModels : BaseViewModel = BaseViewModel.init()
            groupViewModels.subViewModelArray.append(virtualLineViewModel())
            groupViewModels.subViewModelArray.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
            viewModels.append(groupViewModels)
        }
        self.manager?.reloadDataFromViewModels(viewModels:viewModels)
    }
    
    func virtualLineViewModel() -> VirtualLineViewModel {
        let viewModel : VirtualLineViewModel = VirtualLineViewModel.init()
        viewModel.currentCellHeight = 60
        viewModel.title = "测试"
        viewModel.cellClass = VirtualLineCell.self
        viewModel.clickViewBlock = {[weak self](cell : VirtualLineCell , originViewModel : VirtualLineViewModel?) -> Void in
            let aa : CViewController = CViewController.init()
            self?.navigationController?.pushViewController(aa, animated: true)
        }
        return viewModel
    }

    func oneButtonViewModelWith(title : String, bgColor : UIColor, textColor : UIColor, cellType : Int, hasBoardColor : Bool) -> BaseViewModel {
        
        let viewModel : OneButtonViewModel = OneButtonViewModel.init()
        viewModel.buttonTitle = title
        viewModel.buttonBackgroundColor = rgb(red: 246, green: 246, blue: 249)
        viewModel.font = UIFont.boldAdjustFont(fontSize: 16)
        viewModel.cornerRadius = 25.0
        viewModel.space = 50
        viewModel.textColor = rgb(red: 175, green: 177, blue: 184)
        viewModel.canTouch = true
        viewModel.cellClass = OneButtonCell.self
        viewModel.superViewWdith = self.view.frame.size.width
        viewModel.currentCellHeight = 80
        viewModel.clickOneBlock = { [weak self](cell : OneButtonCell , originViewModel : OneButtonViewModel?) -> Void in
             
        }
        return viewModel
    } 
}
