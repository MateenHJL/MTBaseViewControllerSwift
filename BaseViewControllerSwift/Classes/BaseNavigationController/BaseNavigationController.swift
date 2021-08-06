//
//  BaseNavigationController.swift
//  FBSnapshotTestCase
//
//  Created by Sumansoul on 2021/8/3.
//

import UIKit
import UIView_Positioning

open class BaseNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    public var popDelegate : Any?
    
    public var interactivePopTransition : UIPercentDrivenInteractiveTransition?
    
    public var popRecognizer : UIScreenEdgePanGestureRecognizer?
    
    public var isSystemSlidBack : Bool?
    
    public var isPuShingStatus : Bool?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.edgesForExtendedLayout = .all
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self
        self.interactivePopGestureRecognizer?.isEnabled = true
        
        self.popRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(handleNavigationTransition(recognizer:)))
        // Do any additional setup after loading the view.
    }
     

    @objc func handleNavigationTransition(recognizer : UIScreenEdgePanGestureRecognizer) -> Void{
        let progress = recognizer.translation(in: self.view).x / self.view.bounds.size.width
        
        if (recognizer.state == UIGestureRecognizerState.began)
        {
            self.interactivePopTransition = UIPercentDrivenInteractiveTransition.init()
            self.popViewController(animated: true)
        }
        else if (recognizer.state == UIGestureRecognizerState.changed)
        {
            self.interactivePopTransition?.update(progress)
        }
        else if (recognizer.state == UIGestureRecognizerState.ended || recognizer.state == UIGestureRecognizerState.cancelled)
        {
            let velocity = recognizer.velocity(in: recognizer.view)
            if (progress > 0.5 || velocity.x > 100.0)
            {
                self.interactivePopTransition?.finish()
            }
            else
            {
                self.interactivePopTransition?.cancel()
            }
            self.interactivePopTransition = nil
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if (self.isSystemSlidBack == true)
        {
            self.interactivePopGestureRecognizer?.isEnabled = true
            self.popRecognizer?.isEnabled = false
        }
        else
        {
            self.interactivePopGestureRecognizer?.isEnabled = false
            self.popRecognizer?.isEnabled = true
        }
        self.isPuShingStatus = false
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.childViewControllers.count > 1
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.isPuShingStatus == true)
        {
            return
        }
        
        if (self.viewControllers.count > 0)
        {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
        
        var frame : CGRect = self.tabBarController?.tabBar.frame ?? CGRect.zero
        frame.origin.y = UIScreen.main.bounds.size.height - frame.size.height
        self.tabBarController?.tabBar.frame = frame
        
        self.isPuShingStatus = true
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if (viewController.isKind(of: BaseViewController.self))
        {
            let vc : BaseViewController = viewController as! BaseViewController
            vc.view.top = 0
            if (vc.shouldHiddenNavigationBar == true)
            {
                vc.navigationController?.setNavigationBarHidden(true, animated: animated)
            }
            else
            {
                vc.navigationController?.setNavigationBarHidden(false, animated: animated)
            }
        }
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
