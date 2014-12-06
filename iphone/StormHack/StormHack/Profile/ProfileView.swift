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
        username.textAlignment = NSTextAlignment.Center
        logoutButton = UIButton()
        logoutButton.setBackgroundImage(ColorHelper.imageFromHex(0xFF4C4C), forState: UIControlState.Normal)
        logoutButton.setTitle("Logout", forState: UIControlState.Normal)
        logoutButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        picture.setTranslatesAutoresizingMaskIntoConstraints(false)
        username.setTranslatesAutoresizingMaskIntoConstraints(false)
        logoutButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        addSubview(picture)
        addSubview(username)
        addSubview(logoutButton)
    }
    
    internal func setupConstraints() {
        var constraints = [
                            "V:|-150-[picture(150)]-10-[username]",
                            "V:[logoutButton(50)]-80-|",
                            "H:|-85-[picture(150)]-85-|",
                            "H:|-30-[username]-30-|",
                            "H:|-30-[logoutButton]-30-|",
                            ]
        
        var views = Dictionary<String, UIView>()
        views["picture"] = picture
        views["username"] = username
        views["logoutButton"] = logoutButton
        
        ConstraintsHelper.setConstraints(constraints: constraints, views: views, inView: self)
    }
    
    func setData(user: User) {
        picture.sd_setImageWithURL(NSURL(string: user.avatarURL!))
        username.text = user.username
    }

}
