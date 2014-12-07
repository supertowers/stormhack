//
//  ProfileView.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    var picture: UIImageView!
    var username: UILabel!
    var logoutButton: UIButton!
    var rewardTable: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupViews() {
        picture = UIImageView()
        username = UILabel()
        username.font = UIFont(name: "FontAwesome", size: 18)
        username.textAlignment = NSTextAlignment.Center
        logoutButton = UIButton()
        logoutButton.setBackgroundImage(ColorHelper.imageFromHex(0xd9534f), forState: UIControlState.Normal)
        logoutButton.setTitle("Logout", forState: UIControlState.Normal)
        logoutButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        logoutButton.titleLabel?.font = UIFont(name: "FontAwesome", size: 14)
        rewardTable = UITableView()
        
        picture.setTranslatesAutoresizingMaskIntoConstraints(false)
        username.setTranslatesAutoresizingMaskIntoConstraints(false)
        logoutButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        rewardTable.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        addSubview(picture)
        addSubview(username)
        addSubview(logoutButton)
        addSubview(rewardTable)
    }
    
    internal func setupConstraints() {
        var constraints = [
                            "V:|-10-[picture(100)]-10-[rewardTable]|",
                            "V:|-10-[username]-10-[logoutButton(50)]-10-[rewardTable]",
                            "H:|-10-[picture(100)]-15-[username]-10-|",
                            "H:[picture]-15-[logoutButton]-10-|",
                            "H:|[rewardTable]|"
                            ]
        
        var views = Dictionary<String, UIView>()
        views["picture"] = picture
        views["username"] = username
        views["logoutButton"] = logoutButton
        views["rewardTable"] = rewardTable
        
        ConstraintsHelper.setConstraints(constraints: constraints, views: views, inView: self)
    }
    
    func setData(user: User) {
        if user.avatarURL != nil {
            picture.sd_setImageWithURL(NSURL(string: user.avatarURL!))
        }
        username.text = user.username
    }

}
