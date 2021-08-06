//
//  CViewController.swift
//  BaseViewControllerSwift_Example
//
//  Created by Sumansoul on 2021/8/6.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import BaseUIManagerSwift
import KVOController
import pop
import BaseViewControllerSwift

class CViewController: BaseViewController , UITableViewDataSource, UITableViewDelegate{
    
    var table : UITableView?
    var viewModels : Array<BaseViewModel> = []
    @objc dynamic var testTitle : String = "";
    var testView : TestView!
    var testViewModel : TestViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setupUIInterface()

        setupData()
         
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupUIInterface() -> Void {
        self.view.backgroundColor = UIColor.red

        self.testView = TestView.init()
        self.testView.animationType = .point
        self.testView?.frame = CGRect.init(x: -self.view.frame.size.width, y: 120, width: self.view.frame.size.width - 10 * 2, height: 60)
        self.view.addSubview(self.testView!)
        
        self.table = KitFactory.tableView()
        self.table?.frame = CGRect.init(x: 0, y: 200, width: self.view.frame.size.width, height: self.view.frame.size.height - 100)
        self.table!.delegate = self
        self.table!.dataSource = self
        self.view.addSubview(self.table!)
    }

    func setupData() -> Void {

        self.testViewModel = TestViewModel.init()
        self.testViewModel.clickViewBlock = {[weak self](view, originViewModel) -> Void in
            self?.testTitle = "我操~"
        }
        self.testViewModel.title = "哈哈"
        if (true)
        {
            //如果有KVO
            self.testViewModel.unbindViewBlock = {(originViewModel , view) in
                view.kvoController.unobserve(originViewModel, keyPath: "title");
            }
            
            self.testViewModel.bindViewBlock = {(originViewModel , view) in
                view.kvoController.observe(originViewModel, keyPath: "title", options: .new, context: nil);
            }
            
            self.testViewModel.observerKeyPathChangedBlock = {(originViewModel  , keyPath , object ) in
                if (keyPath == "testTitle")
                {
                    (originViewModel as! TestViewModel).title = (object as! CViewController).testTitle
                }
            }
            self.testViewModel.kvoControllerNonRetaining.observe(self, keyPath: "testTitle", options: .new, context: nil)
        }
        self.testView.resetViewWithViewModel(viewModel: self.testViewModel!)
        
        resetViewModel()
    }

    func resetViewModel() -> Void {
        self.viewModels .removeAll()

        if (true)
        {
            let baseViewModel : VirtualLineViewModel = virtualLineViewModel();
            self.viewModels.append(baseViewModel)
            baseViewModel.unbindCellBlock = {(originViewModel , cell) in
                cell.kvoController.unobserve(originViewModel, keyPath: "title");
            }
            baseViewModel.bindCellBlock = {(originViewModel , cell) in
                cell.kvoController.observe(originViewModel, keyPath: "title", options: .new, context: nil);
            }
            baseViewModel.observerKeyPathChangedBlock = {(originViewModel  , keyPath , object ) in
                if (keyPath == "testTitle")
                {
                    (originViewModel as! VirtualLineViewModel).title = (object as! CViewController).testTitle;
                }
            }
            baseViewModel.kvoControllerNonRetaining.observe(self, keyPath: "testTitle", options: [.new], context: nil)
        }
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
        self.viewModels.append(oneButtonViewModelWith(title: "登录", bgColor: rgb(red: 246, green: 246, blue: 249), textColor: rgb(red: 175, green: 177, blue: 184), cellType: 0, hasBoardColor: false))
        self.table!.registerCellWithViewModels(viewModels: self.viewModels)
        self.table?.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModels[indexPath.row]
        if (viewModel.cellIndentifier!.count > 0)
        {
            let cell = self.table!.dequeueReusableCell(withIdentifier: viewModel.cellIndentifier!)
            (cell! as! BaseTableViewCell).resetCellWithViewModel(viewModel: viewModel)
            return (cell as! BaseTableViewCell)
        }
        return UITableViewCell.init()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = self.viewModels[indexPath.row]
        if (viewModel.currentCellHeight == 0.0)
        {
            viewModel.currentCellHeight = (viewModel.cellClass?.currentCellHeightWithViewModel(viewmodel: viewModel))!
            return viewModel.currentCellHeight;
        }
        return viewModel.currentCellHeight
    }

    func virtualLineViewModel() -> VirtualLineViewModel {
        let viewModel : VirtualLineViewModel = VirtualLineViewModel.init()
        viewModel.currentCellHeight = 60
        viewModel.title = "测试"
        viewModel.cellClass = VirtualLineCell.self
        viewModel.clickViewBlock = {[weak self](cell : VirtualLineCell , originViewModel : VirtualLineViewModel?) -> Void in
            
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
            
            self?.testTitle = Date.init().description;
            
            self?.testView.pointValue = CGPoint.init(x: 10, y: 120)
            self?.testView.refreshViewAttributedAnimationWithCompletedBlock(block: { (pop : POPAnimation?, isFinished : Bool) in
                
            })
            
            let aa : GroupViewController = GroupViewController.init()
            self?.navigationController!.pushViewController(aa, animated: true)
        }
        return viewModel
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
