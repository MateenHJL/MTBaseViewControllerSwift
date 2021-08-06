//
//  KitFactory.swift
//  BaseUIManagerSwift
//
//  Created by Sumansoul on 2021/7/23.
//

import Foundation
import UIKit
import Hue

open class KitFactory {
    
    static let kDefaultTextColor = rgb(red: 51, green: 51, blue: 51)
    static let kDefaultFontSize = UIFont.systemAdjustFont(fontSize: 14)
    static let kDefaultBackgroundColor = UIColor.clear
    static let kDefaultHighTextColor = rgb(red: 51, green: 51, blue: 51)
    
    public static func collectionViewfLowLayout () -> UICollectionViewFlowLayout{
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        return flowLayout
    }
    
    public static func collectionViewWithLayout (layout : UICollectionViewFlowLayout) -> UICollectionView{
        let collectionView : UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    
    public static func view () -> UIView{
        let view : UIView = UIView.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = kDefaultBackgroundColor
        return view
    }
    
    public static func label () -> UILabel{
        let label = UILabel.init()
        label.backgroundColor = kDefaultBackgroundColor
        label.font = kDefaultFontSize
        label.textColor = kDefaultTextColor
        return label
    }
    
    public static func button () -> UIButton{
        let button : UIButton = UIButton.init(type: UIButtonType.custom)
        button.backgroundColor = kDefaultBackgroundColor
        button.setTitleColor(kDefaultTextColor, for: UIControlState.normal)
        button.titleLabel?.font = kDefaultFontSize
        button.setTitleColor(kDefaultHighTextColor, for: UIControlState.highlighted)
        return button
    }
    
    public static func textField () -> UITextField{
        let textField : UITextField = UITextField.init()
        textField.backgroundColor = kDefaultBackgroundColor
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.spellCheckingType = UITextSpellCheckingType.no
        textField.font = kDefaultFontSize
        textField.enablesReturnKeyAutomatically = true
        textField.textColor = kDefaultTextColor
        textField.keyboardType = UIKeyboardType.default
        return textField
    }
    
    public static func textView () -> UITextView{
        let textView : UITextView = UITextView.init()
        textView.backgroundColor = kDefaultBackgroundColor
        textView.textColor = kDefaultTextColor
        textView.font = kDefaultFontSize
        textView.keyboardType = UIKeyboardType.default
        textView.returnKeyType = UIReturnKeyType.done
        return textView
    }
    
    public static func imageView () -> UIImageView{
        let imageView : UIImageView = UIImageView.init()
        imageView.backgroundColor = kDefaultBackgroundColor
        return imageView
    }
    
    public static func tableView () -> UITableView{
        let table : UITableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        table.separatorColor = UIColor.clear
        table.separatorInset = UIEdgeInsets.zero
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        table.backgroundView = UIView.init()
        table.backgroundColor = UIColor.clear
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *)
        {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        }
        table.estimatedRowHeight = 0
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        return table
    }
    
    public static func scrollView () -> UIScrollView{
        let scrollView : UIScrollView = UIScrollView.init()
        scrollView.backgroundColor = UIColor.clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0 , *)
        {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        }
        return scrollView
    }
}
