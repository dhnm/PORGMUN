//
//  TabBarController.swift
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 08/02/2017.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    // other settings in AppDelegate
    
    let selectedColor   = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.00)
    let unselectedColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.40)
    let porgmunColor = UIColor(red:0.00, green:0.36, blue:0.64, alpha:1.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NAVIGATION BAR
        
        UIApplication.shared.statusBarStyle = .default
        
        UINavigationBar.appearance().barTintColor = .white // top bar background color
        /*UINavigationBar.appearance().setBackgroundImage(UIImage.imageWithColor(color: UIColor.clear, size: CGSize(width: 1, height: 1)), for: .default)
         let blurEffect = UIBlurEffect(style: .light)
         let blurEffectView = UIVisualEffectView(effect: blurEffect)
         blurEffectView.frame = UINavigationBar.appearance().bounds
         UINavigationBar.appearance().insertSubview(blurEffectView, at: 0)*/
        
        UINavigationBar.appearance().tintColor = .black // top bar buttons color
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black] // top bar text color
        UINavigationBar.appearance().isTranslucent = true
        
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().prefersLargeTitles = true
        }
        
        // TAB BAR
        
        //    self.tabBar.items?[0].image = #imageLiteral(resourceName: "fa-calendar@3x.png").withRenderingMode(.alwaysTemplate)
        //    self.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "fa-calendar@3x.png").withRenderingMode(.alwaysTemplate)
        //
        //    self.tabBar.items?[1].image = #imageLiteral(resourceName: "fa-newspaper@2x.png").withRenderingMode(.alwaysTemplate)
        //    self.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "fa-newspaper@2x.png").withRenderingMode(.alwaysTemplate)
        //
        //    self.tabBar.items?[2].image = #imageLiteral(resourceName: "fa-handshake@2x.png").withRenderingMode(.alwaysTemplate)
        //    self.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "fa-handshake@2x.png").withRenderingMode(.alwaysTemplate)
        //
        //    self.tabBar.items?[3].image = #imageLiteral(resourceName: "fa-book@3x.png").withRenderingMode(.alwaysTemplate)
        //    self.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "fa-book@3x.png").withRenderingMode(.alwaysTemplate)
        //
        //    self.tabBar.items?[4].image = #imageLiteral(resourceName: "fa-id@2x.png").withRenderingMode(.alwaysTemplate)
        //    self.tabBar.items?[4].selectedImage = #imageLiteral(resourceName: "fa-id@2x.png").withRenderingMode(.alwaysTemplate)
        //
        //    let numberOfItems = CGFloat(tabBar.items!.count)
        //    let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        //
        //    self.tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.lightText.withAlphaComponent(0.15), size: tabBarItemSize)
        //
        //    self.tabBar.barTintColor = .white // botom bar bg color
        //    /*self.tabBar.backgroundImage = UIImage.imageWithColor(color: UIColor.clear, size: CGSize(width: 1, height: 1))
        //     blurEffectView.frame = self.tabBar.bounds
        //     self.tabBar.insertSubview(blurEffectView, at: 0)*/
        //
        //    self.tabBar.tintColor = selectedColor // bottom bar selected icon color
        //    if #available(iOS 10.0, *) {
        //      self.tabBar.unselectedItemTintColor = unselectedColor
        //    }
        //    self.tabBar.isTranslucent = true
        //
        //    UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: unselectedColor], for: .normal)
        //    UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: selectedColor], for: .selected)
        //    UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "ProximaNova-Regular", size: 10)!], for: .normal)
        //    UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "ProximaNova-Regular", size: 10)!], for: .selected
    }
}

extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UINavigationBar
{
    var titleHeight: CGFloat {
        let maxSize = self.subviews
            .filter { $0.frame.origin.y > 0 }
            .max { $0.frame.origin.y < $1.frame.origin.y }
            .map { $0.frame.size }
        return maxSize?.height ?? 0
    }
}
