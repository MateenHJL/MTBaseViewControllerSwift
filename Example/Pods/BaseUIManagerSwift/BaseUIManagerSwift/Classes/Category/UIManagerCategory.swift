//
//  UIManagerCategory.swift
//  BaseUIManagerSwift
//
//  Created by Sumansoul on 2021/7/27.
//

import pop

private let kDuration   : CGFloat = 0.4
private var kAlphaValue : String  = "kAlphaValue"
private var kPointValue : String  = "kPointValue"
private var kSizeValue  : String  = "kSizeValue"
private var kRectValue  : String  = "kRectValue"
private let kAlpha      : String  = "kAlpha"
private let kPoint      : String  = "kPoint"
private let kSize       : String  = "kSize"
private let kRect       : String  = "kRect"

extension UIColor{
    public static func randomColor () -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

public func rgb(red: Int , green : Int, blue : Int) -> UIColor {
    let tRed : CGFloat = CGFloat(red) / 255.0
    let tGreen : CGFloat = CGFloat(green) / 255.0
    let tBlue : CGFloat = CGFloat(blue) / 255.0
    return UIColor.init(red: tRed, green: tGreen, blue: tBlue, alpha: 1.0)
}

public func rgba(red: Int , green : Int, blue : Int , alpha : CGFloat) -> UIColor {
    let tRed : CGFloat = CGFloat(red) / 255.0
    let tGreen : CGFloat = CGFloat(green) / 255.0
    let tBlue : CGFloat = CGFloat(blue) / 255.0
    return UIColor.init(red: tRed, green: tGreen, blue: tBlue, alpha: alpha)
}

public func RGB(red: Int , green : Int, blue : Int) -> UIColor {
    return rgb(red: red, green: green, blue: blue)
}

public func RGBA(red: Int , green : Int, blue : Int , alpha : CGFloat) -> UIColor {
    rgba(red: red, green: green, blue: blue, alpha: alpha)
}

func adjustFontFromFontSize(fontSize : Int) -> CGFloat {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
    {
        if (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portrait)
        {
            return CGFloat(fontSize) * UIScreen.main.bounds.size.width / 375.0
        }
        else if (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeLeft || UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeRight)
        {
            return CGFloat(fontSize) * UIScreen.main.bounds.size.height / 375.0
        }
        return CGFloat(fontSize) * UIScreen.main.bounds.size.width / 375.0
    }
    else
    {
        if (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portrait)
        {
            return CGFloat(fontSize) * UIScreen.main.bounds.size.width / 768
        }
        else if (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeLeft || UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeRight)
        {
            return CGFloat(fontSize) * UIScreen.main.bounds.size.height / 768
        }
        return CGFloat(fontSize) * UIScreen.main.bounds.size.width / 768
    }
}


extension UIFont{
    public static func systemAdjustFont(fontSize : Int) -> UIFont {
        return UIFont.systemFont(ofSize: adjustFontFromFontSize(fontSize: fontSize))
    }
    
    public static func boldAdjustFont(fontSize : Int) -> UIFont {
        return UIFont.boldSystemFont(ofSize: adjustFontFromFontSize(fontSize: fontSize))
    }
}

extension UIView{
    
    public typealias tAnimationDidEndBlock = (POPAnimation? , Bool) -> Void
    
    public var alphaValue : CGFloat {
        set
        {
            objc_setAssociatedObject(self, &kAlphaValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get
        {
            return (objc_getAssociatedObject(self, &kAlphaValue) as? CGFloat)!
        }
    }
    
    public var pointValue : CGPoint?{
        set
        {
            objc_setAssociatedObject(self, &kPointValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get
        {
            return objc_getAssociatedObject(self, &kPointValue) as? CGPoint
        }
    }
    
    public var sizeValue : CGSize?{
        set
        {
            objc_setAssociatedObject(self, &kSizeValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get
        {
            return objc_getAssociatedObject(self, &kSizeValue) as? CGSize
        }
    }
    
    public var rectValue :CGRect?{
        set
        {
            objc_setAssociatedObject(self, &kRectValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get
        {
            return objc_getAssociatedObject(self, &kRectValue) as? CGRect
        }
    }
    
    func animationWithFadeCompletedUsing(animationBlock : @escaping(tAnimationDidEndBlock)) -> Void {
        let anim : POPBasicAnimation = POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
        anim.duration = CFTimeInterval(kDuration)
        anim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.toValue = self.alphaValue
        anim.completionBlock = { (animation : POPAnimation? , finished : Bool) -> Void in
            animationBlock (animation , finished)
        }
        self.pop_add(anim, forKey: kAlpha)
    }
    
    func animationWithPointCompletedUsing(animationBlock : @escaping(tAnimationDidEndBlock)) -> Void {
        let basicAnimation : POPSpringAnimation = POPSpringAnimation.init(propertyNamed: kPOPViewFrame)
        basicAnimation.toValue = NSValue.init(cgRect: CGRect.init(x: self.pointValue!.x, y: self.pointValue!.y, width: self.frame.size.width, height: self.frame.size.height))
        basicAnimation.completionBlock = { (animation : POPAnimation? , finished : Bool) -> Void in
            animationBlock (animation , finished)
        }
        self.pop_add(basicAnimation, forKey: kPoint)
    }
    
    func animationWithSizeCompletedUsing(animationBlock : @escaping(tAnimationDidEndBlock)) -> Void {
        let basicAnimation : POPBasicAnimation = POPBasicAnimation.init(propertyNamed: kPOPViewSize)
        basicAnimation.toValue = NSValue.init(cgSize: self.sizeValue!)
        basicAnimation.completionBlock = { (animation : POPAnimation? , finished : Bool) -> Void in
            animationBlock (animation , finished)
        }
        self.pop_add(basicAnimation, forKey: kSize)
    }
    
    func animationWithRectCompletedUsing(animationBlock : @escaping(tAnimationDidEndBlock)) -> Void {
        let basicAnimation : POPBasicAnimation = POPBasicAnimation.init(propertyNamed: kPOPViewFrame)
        basicAnimation.toValue = NSValue.init(cgRect: self.rectValue!)
        basicAnimation.duration = CFTimeInterval(kDuration)
        basicAnimation.completionBlock = { (animation : POPAnimation? , finished : Bool) -> Void in
            animationBlock (animation , finished)
        }
        self.pop_add(basicAnimation, forKey: kSize)
    }
}

extension UITableView{
    public func registerCellClass(tableviewCell : AnyClass , cellIndentifier : String) -> Void {
        self.register(tableviewCell, forCellReuseIdentifier: cellIndentifier)
    }
    
    public func registerCellWithViewModels(viewModels : Array<BaseViewModel>) -> Void {
        if (viewModels.count == 0)
        {
            print("注册cell失败，viewModel为nil")
            return
        }
        
        for viewModel in viewModels
        {
            if (viewModel.cellClass != nil && viewModel.cellIndentifier!.count > 0)
            {
                if let realCellIndentifier = viewModel.cellIndentifier , let realCellClass = viewModel.cellClass
                {
                    self.registerCellClass(tableviewCell: realCellClass, cellIndentifier: realCellIndentifier)
                }
            }
        }
    }
}


