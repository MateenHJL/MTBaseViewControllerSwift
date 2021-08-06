//
//  BaseViewController.swift
//  FBSnapshotTestCase
//
//  Created by Sumansoul on 2021/8/3.
//

import UIKit
import IQKeyboardManagerSwift
import BaseUIManagerSwift
import UIView_Positioning

open class BaseViewController: UIViewController {

    //the indentifier of current viewController
    public var remarkTitle : String?
    
    //modify statusbar's backgroundColor
    public var statusBarBackgroundColor : UIColor!{
        didSet
        {
            if #available(iOS 13.0, *)
            {
                if (self.statusBarView == nil)
                {
                    self.statusBarView = KitFactory.view()
                    let statusBarFrame : CGRect = UIApplication.shared.statusBarFrame
                    self.statusBarView.frame = CGRect.init(x: statusBarFrame.origin.x, y: statusBarFrame.origin.y, width: statusBarFrame.width, height: statusBarFrame.height)
                }
                self.statusBarView.backgroundColor = statusBarBackgroundColor
            }
            else
            {
                let statusBar : UIView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as! UIView
                statusBar.backgroundColor = statusBarBackgroundColor
            }
        }
    }
    
    //modify Status bar Style
    public var statusBarStyle : UIStatusBarStyle?{
        didSet{
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    //wether navigationBar is hidden
    public var shouldHiddenNavigationBar : Bool?
    
    //wether has backButton
    public var shouldShowBackButton : Bool = true{
        didSet{
            let vcCount : Int = (self.navigationController?.viewControllers.count)!
            if (shouldShowBackButton && (vcCount > 1 || self.navigationController?.presentationController != nil))
            {
                let buttonViewModel : ButtonViewModel = ButtonViewModel.init()
                buttonViewModel.buttonImage = BaseViewControllerConfigManager.shareViewControllerConfig().config.defaultBackIcon()
                buttonViewModel.buttonSelector = #selector(respondsToLeftNavigationButton(button:))
                self.createLeftNavigationItem(buttonViewModel: [buttonViewModel], and: self)
            }
            else
            {
                self.navigationItem.hidesBackButton = true
                self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView.init())
            }
        }
    }
    
    var statusBarView : UIView!
    
    //create more button with buttonArray for leftNavigationItem
    public func createLeftNavigationItem(buttonViewModel : Array<ButtonViewModel> , and target : Any) -> Void {
        if (buttonViewModel.count > 0)
        {
            self.navigationItem.leftBarButtonItems = nil
            
            var items : Array<UIBarButtonItem> = []
            
            for viewModel in buttonViewModel {
                let leftNavigationButton : UIButton = UIButton.init(type: .custom)
                leftNavigationButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
                if ((viewModel.buttonText?.count) ?? 0 > 0)
                {
                    leftNavigationButton.setTitle(viewModel.buttonText, for: .normal)
                    leftNavigationButton.titleLabel?.font = viewModel.font
                    leftNavigationButton.setTitleColor(viewModel.buttonTextColor, for: .normal)
                }
                else
                {
                    leftNavigationButton.setImage(viewModel.buttonImage, for: .normal)
                }
                leftNavigationButton.sizeToFit()
                leftNavigationButton.addTarget(self, action: viewModel.buttonSelector!, for: .touchUpInside)
                leftNavigationButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
                
                let item : UIBarButtonItem = UIBarButtonItem.init(customView: leftNavigationButton)
                items.append(item)
            }
            self.navigationItem.leftBarButtonItems = items
        }
    }
    
    //create more button with buttonArray for rightNavigationItem
    public func createRightNavigationItem(buttonViewModel : Array<ButtonViewModel> , and target : Any) -> Void {
        if (buttonViewModel.count > 0)
        {
            self.navigationItem.rightBarButtonItems = nil
            
            var items : Array<UIBarButtonItem> = []
            
            for viewModel in buttonViewModel {
                let leftNavigationButton : UIButton = UIButton.init(type: .custom)
                leftNavigationButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
                if ((viewModel.buttonText?.count)! > 0)
                {
                    leftNavigationButton.setTitle(viewModel.buttonText, for: .normal)
                    leftNavigationButton.titleLabel?.font = viewModel.font
                    leftNavigationButton.setTitleColor(viewModel.buttonTextColor, for: .normal)
                }
                else
                {
                    leftNavigationButton.setImage(viewModel.buttonImage, for: .normal)
                }
                leftNavigationButton.sizeToFit()
                leftNavigationButton.addTarget(self, action: viewModel.buttonSelector!, for: .touchUpInside)
                leftNavigationButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
                
                let item : UIBarButtonItem = UIBarButtonItem.init(customView: leftNavigationButton)
                items.append(item)
            }
            self.navigationItem.rightBarButtonItems = items
        }
    }
    
    //selector of LeftButton
    public func baseControllerClick(leftButton : UIButton) -> Void {
        if (self.presentationController != nil)
        {
            self.dismiss(animated: true) {
                
            }
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.edgesForExtendedLayout = .all
        
        self.shouldHiddenNavigationBar = false
        
        if (self.responds(to: #selector(setter: automaticallyAdjustsScrollViewInsets)))
        {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.shared.resignFirstResponder()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : BaseViewControllerConfigManager.shareViewControllerConfig().config.defaultNavigationTextColor(),NSAttributedStringKey.font : BaseViewControllerConfigManager.shareViewControllerConfig().config.defaultNavigationTitleFont()]
        
        super.viewWillAppear(animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.resignFirstResponder()
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = false
        super.viewWillDisappear(animated)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    
        self.statusBarStyle = .default
        self.statusBarBackgroundColor = BaseViewControllerConfigManager.shareViewControllerConfig().config.defaultStatusBarBackgroundColor()
        self.view.backgroundColor = BaseViewControllerConfigManager.shareViewControllerConfig().config.defaultViewBackground()
        self.shouldShowBackButton = true
        // Do any additional setup after loading the view.
    }
    
    @objc func respondsToLeftNavigationButton (button : UIButton) -> Void{
        self.baseControllerClick(leftButton: button)
    }
    
    deinit {
        BaseViewControllerConfigManager.shareViewControllerConfig().config.superDeallocWithController(viewController: self)
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
