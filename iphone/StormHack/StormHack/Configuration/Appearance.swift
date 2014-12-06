//
//  Appearance.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class Appearance: NSObject {
    class func setupNavbar() {
        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "FontAwesome", size: 15)]
        
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "FontAwesome", size: 10)], forState: UIControlState.Normal)
        
    }
}
