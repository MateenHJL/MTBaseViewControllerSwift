//
//  BaseTabbarController.swift
//  BaseViewControllerSwift
//
//  Created by Sumansoul on 2021/8/3.
//

import UIKit

@objc public protocol BaseTabbarControllerSelectedDelegate {
    func baseTabbarControllerDidSelected(index : Int , currentIndex : Int, choosedViewController : BaseNavigationController) -> Void
}

public class BaseTabbarController: UITabBarController, UITabBarControllerDelegate {

    public weak var selectedDelegate : BaseTabbarControllerSelectedDelegate?
    
    var dataSource          : Array<BaseTabbarItem> = []
    var rootControllerArray : Array<BaseNavigationController> = []
    var currentIndex        : Int = 0

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.isOpaque = false
        self.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func resetTabbarForDataModelArray (modelArray : Array<BaseTabbarItem>) -> Void{
        self.dataSource.removeAll()
        self.dataSource.append(contentsOf: modelArray)
        if (self.dataSource.count > 0)
        {
            self.rootControllerArray.removeAll()
            for item in modelArray {
                if let tmpRootController = item.classInstance
                {
                    let rootController : BaseNavigationController = BaseNavigationController.init(rootViewController: tmpRootController)
                    if let tmpNormalImage = item.normalImage
                    {
                        rootController.tabBarItem.image = tmpNormalImage.withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let tmpSelectedImage = item.selectedImage
                    {
                        rootController.tabBarItem.selectedImage = tmpSelectedImage.withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let tmpNormalTitle = item.normalTitle
                    {
                        rootController.tabBarItem.title = tmpNormalTitle
                    }
                
                    rootController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : BaseViewControllerConfigManager.shareViewControllerConfig().config.tabbarSelectTextColor(),NSAttributedStringKey.font : BaseViewControllerConfigManager.shareViewControllerConfig().config.tabbarSelectFont()], for: UIControlState.selected)
                    rootController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : BaseViewControllerConfigManager.shareViewControllerConfig().config.tabbarNormalTextColor(),NSAttributedStringKey.font : BaseViewControllerConfigManager.shareViewControllerConfig().config.tabbarNormalFont()], for: UIControlState.normal)
                    self.rootControllerArray.append(rootController)
                }
            }
            self.viewControllers = rootControllerArray
        }
    }
    
    public func refreshTabbarItemWithTabbarItem (tabbarItem : BaseTabbarItem) -> Void{
        
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = self.rootControllerArray.firstIndex(of: viewController as! BaseNavigationController)
        self.selectedDelegate?.baseTabbarControllerDidSelected(index: index!, currentIndex: self.currentIndex, choosedViewController: (viewController as! BaseNavigationController))
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.currentIndex = self.selectedIndex
        return true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
