//
//  BaseExtension.swift
//  BaseViewControllerSwift
//
//  Created by Sumansoul on 2021/8/4.
//

import CoreGraphics
import BaseUIManagerSwift

//screen
public let kScreenWidth  : CGFloat = UIScreen.main.bounds.size.width
public let kScreenHeight : CGFloat = UIScreen.main.bounds.size.height

//navigationBar height
public let kNavigationBarHeight : CGFloat = kOriginNavigationBarHeight()

//statusBar height
public let kStatusBarHeight : CGFloat = kOriginStatsuBarHeight()

//navigationSafetySpaceHeight
public let kNavigationTopSpace : CGFloat = kSafetyTopSpace()

//bottomSafetySpaceHeight
public let kIphoneXBottomSpace : CGFloat = kSafetyBottomSpace()

//navigationHeight
public let kNavigationHeight : CGFloat = kOriginNavigationHeight()

//tabbarHeight
public let kTabbarHeight : CGFloat = kOriginTabbarHeight()

//iphone?
public let kIsIphone : Bool = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone

//is ipad?
public let kIsIpad : Bool = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad

//if it was iphone 4
public let kIphone4 : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 640, height: 960))

//if it was iphone 5
public let kIphone5 : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 640, height: 1136))

//if it was iphone 6
public let kIphone6 : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 750, height: 1334))

//if it was iphone 6p
public let kIphone6p : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 1242, height: 2208))

//if it was iphone x
public let kIphonex : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 1125, height: 2436))

//if it was iphone xr
public let kIphoneXR : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 828, height: 1792))

//if it was iphone xs
public let kIphoneXS : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 1125, height: 2436))

//if it was iPhoneXs Max
public let kIphoneXSMAX : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 1242, height: 2688))

//if it was iPHone12 mini
public let kIphone12MINI : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 1080, height: 2340))

//if it was iPHone12 and iPHone12 Pro
public let kIphone12AndPro : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 1170, height: 2532))

//if it was iPHone12 ProMax
public let kIphone12ProMax : Bool = UIScreen.main.currentMode!.size.equalTo(CGSize.init(width: 1284, height: 2778))

//screen scale percent for height
public func kPercentageHeight(height : Int) -> CGFloat{
    if (kIsIphone)
    {
        return kScreenHeight * CGFloat(Float(height)) / 667.0
    }
    else if (kIsIpad)
    {
        return kScreenHeight * CGFloat(Float(height)) / 1024.0
    }
    return CGFloat(height)
}

//screen scale percent for width
public func kPercentageWidth(width : Int) -> CGFloat{
    if (kIsIphone)
    {
        return kScreenWidth / 375.0 * CGFloat(width)
    }
    else if (kIsIpad)
    {
        return kScreenWidth / 768.0 * CGFloat(width)
    }
    return CGFloat(width)
}

func kOriginStatsuBarHeight() -> CGFloat {
    return UIApplication.shared.statusBarFrame.size.height
}

func kSafetyTopSpace() -> CGFloat {
    if #available(iOS 11.0, *)
    {
        return UIApplication.shared.keyWindow!.safeAreaInsets.top
    }
    return 0.0
}

func kSafetyBottomSpace() -> CGFloat {
    return isSupportFaceId() ? 34.0 : 0.0;
}

func kOriginNavigationHeight() -> CGFloat {
    return kOriginStatsuBarHeight() + kOriginNavigationBarHeight()
}

func kOriginNavigationBarHeight() -> CGFloat {
    return kIsIphone ? 44.0 : 50.0
}

func kOriginTabbarHeight() -> CGFloat {
    if (!kIsIpad)
    {
        if (isSupportFaceId())
        {
            return 83.0
        }
        else
        {
            return 49.0
        }
    }
    else
    {
        if (kOriginStatsuBarHeight() > 23.0)
        {
            return 65.0
        }
        else
        {
            return 50.0
        }
    }
}

func isSupportFaceId() -> Bool {
    if #available(iOS 11.0, *)
    {
        let keyWindow = UIApplication.shared.keyWindow
        let bottomSafeInset : CGFloat = keyWindow!.safeAreaInsets.bottom
        if (bottomSafeInset == 34.0 || bottomSafeInset == 21.0 || bottomSafeInset == 20.0)
        {
            return true
        }
    }
    return false
}

public func createImageWith(color : UIColor) -> UIImage {
    let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let contect : CGContext = UIGraphicsGetCurrentContext()!
    contect.setFillColor(color.cgColor)
    contect.addRect(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}

