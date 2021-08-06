//
//  SimpleTableViewManager.swift
//  BaseUIManagerSwift
//
//  Created by Sumansoul on 2021/8/5.
//

import Foundation

open class SimpleTableViewManager: BaseTableManager, UITableViewDelegate, UITableViewDataSource {
    
    public override init(target: AnyObject) {
    
        super.init(target: target)

        self.target = target
        
        setupUIInterface()
    }
     
    func setupUIInterface() -> Void {
        self.table = KitFactory.tableView()
        self.table?.delegate = self
        self.table?.dataSource = self
    }

    open override func reloadDataFromViewModels(viewModels: Array<BaseViewModel>) {
        self.viewModels = viewModels
        self.table?.registerCellWithViewModels(viewModels: self.viewModels)
        self.table?.reloadData()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModels[indexPath.row]
        if let tmpCellIndentifier = viewModel.cellIndentifier , tmpCellIndentifier.count > 0
        {
            let cell = self.table!.dequeueReusableCell(withIdentifier: tmpCellIndentifier)
            if let tmpCell = cell
            {
                (tmpCell as! BaseTableViewCell).resetCellWithViewModel(viewModel: viewModel)
                return (cell as! BaseTableViewCell)
            }
        }
        return UITableViewCell.init()
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = self.viewModels[indexPath.row]
        if (viewModel.currentCellHeight == 0.0)
        {
            if let tmpCellClass = viewModel.cellClass
            {
                viewModel.currentCellHeight = tmpCellClass.currentCellHeightWithViewModel(viewmodel: viewModel)
            }
        }  
        return viewModel.currentCellHeight;
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let tmpWillDisplayCellBlockBlock = willDisplayCellBlockBlock
        {
            tmpWillDisplayCellBlockBlock (self , self.table,  cell as? BaseTableViewCell, indexPath)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.viewModels[indexPath.row]
        if let tmpBlock = didSelectedRowAtIndexPathBlock
        {
            tmpBlock (self , self.table, indexPath , nil , viewModel)
        }
    }
    
    public override func reloadData() {
        self.table?.registerCellWithViewModels(viewModels: self.viewModels)
        self.table?.reloadData()
    }
}
