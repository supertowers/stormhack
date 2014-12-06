//
//  ViewController.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabbar()
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func setupTabbar() {
        let listnc = UINavigationController(rootViewController: ListViewController())
        let rankingnc = UINavigationController(rootViewController: RankingViewController())
        let profilenc = UINavigationController(rootViewController: ProfileViewController())
        
        var listIcon: FAKFontAwesome = FAKFontAwesome.listIconWithSize(15)
        var rankingIcon: FAKFontAwesome = FAKFontAwesome.starIconWithSize(15)
        var profileIcon: FAKFontAwesome = FAKFontAwesome.userIconWithSize(15)
        
        listnc.tabBarItem = UITabBarItem(title: "Sitios Web", image: listIcon.imageWithSize(CGSizeMake(15, 15)), tag: 1)
        rankingnc.tabBarItem = UITabBarItem(title: "Pentesters", image: rankingIcon.imageWithSize(CGSizeMake(15, 15)), tag: 2)
        profilenc.tabBarItem = UITabBarItem(title: "Perfil", image: profileIcon.imageWithSize(CGSizeMake(15, 15)), tag: 3)
        self.setViewControllers([listnc, rankingnc, profilenc], animated: true)
        self.selectedIndex = 0
        self.title = "STORMHACK"
    }


}

