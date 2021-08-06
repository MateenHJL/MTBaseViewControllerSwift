//
//  TestViewController.swift
//  BaseViewControllerSwift_Example
//
//  Created by Sumansoul on 2021/8/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BaseUIManagerSwift
import BaseViewControllerSwift

class TestViewController: BaseViewController {

    var manager : SimpleTableViewManager?
    
    override func viewDidLoad() {
        self.manager = SimpleTableViewManager.init(target: self)
        self.manager?.table?.frame = CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height - 200)
        self.manager?.didSelectedRowAtIndexPathBlock? = {(manager : BaseTableManager, table : UITableView? , indexPath : IndexPath,  sectionViewModel : BaseViewModel? , rowViewModel : BaseViewModel?) -> Void in
            
        }
        self.manager?.willDisplayCellBlockBlock? = {(manager : BaseTableManager, table : UITableView? , cell : BaseTableViewCell?, indexPath : IndexPath) in
            
        }
        if let tmpTable = self.manager?.table
        {
            self.view.addSubview(tmpTable)
        }
        
        var viewModels : Array<BaseViewModel> = []
        viewModels.append(virtualLineViewModel())
        viewModels.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
        viewModels.append(virtualLineViewModel())
        viewModels.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
        viewModels.append(virtualLineViewModel())
        viewModels.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
        viewModels.append(virtualLineViewModel())
        viewModels.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
        viewModels.append(virtualLineViewModel())
        viewModels.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
        viewModels.append(virtualLineViewModel())
        viewModels.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
        viewModels.append(virtualLineViewModel())
        viewModels.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
        viewModels.append(virtualLineViewModel())
        viewModels.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
        viewModels.append(virtualLineViewModel())
        viewModels.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
        viewModels.append(virtualLineViewModel())
        viewModels.append(oneButtonViewModelWith(title: "测试1", bgColor: rgb(red: 51, green: 51, blue: 51), textColor: rgb(red: 51, green: 5, blue: 51), cellType: 0, hasBoardColor: false))
        self.manager?.reloadDataFromViewModels(viewModels:viewModels)
    }
    
    func virtualLineViewModel() -> VirtualLineViewModel {
        let viewModel : VirtualLineViewModel = VirtualLineViewModel.init()
        viewModel.currentCellHeight = 60
        viewModel.title = "测试"
        viewModel.cellClass = VirtualLineCell.self
        viewModel.clickViewBlock = {[weak self](cell : VirtualLineCell , originViewModel : VirtualLineViewModel?) -> Void in
            let aa : GroupViewController = GroupViewController.init()
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
            var index = NSNotFound
            if let tmpViewModels = self?.manager?.viewModels
            {
                for (i, element) in tmpViewModels.enumerated()
                {
                    if (originViewModel == element)
                    {
                        index = i
                        break
                    }
                }
            }
            if index != NSNotFound
            {
                self?.manager?.viewModels.remove(at: index)
                self?.manager?.reloadDataFromViewModels(viewModels: (self?.manager?.viewModels)!)
            }
        }
        return viewModel
    }
    
    deinit {
        print("simple 释放了")
    }
}

