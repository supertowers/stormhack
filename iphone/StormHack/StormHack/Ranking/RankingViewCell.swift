//
//  RankingViewCell.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class RankingViewCell: UITableViewCell {
    
    var avatar: UIImageView!
    var username: UILabel!
    var points: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupViews() {
        avatar = UIImageView()
        username = UILabel()
        username.font = UIFont.boldSystemFontOfSize(18)
        points = UILabel()
        
        avatar.setTranslatesAutoresizingMaskIntoConstraints(false)
        username.setTranslatesAutoresizingMaskIntoConstraints(false)
        points.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        contentView.addSubview(avatar)
        contentView.addSubview(username)
        contentView.addSubview(points)
        
    }
    
    internal func setConstraints() {
    
        var constraints = [
                            "V:|-10-[avatar(50)]-10-|",
                            "V:|-20-[username]-20-|",
                            "V:|-20-[points]-20-|",
                            "H:|-10-[avatar(50)]-10-[username]-10-[points(50)]-10-|"
                            ]
        
        var views = Dictionary<String, UIView>()
        views["avatar"] = avatar
        views["username"] = username
        views["points"] = points
        
        ConstraintsHelper.setConstraints(constraints: constraints, views: views, inView: contentView)
        
    }
    
    func setData(r: Ranking) {
        avatar.sd_setImageWithURL(NSURL(string: r.avatarURL))
        username.text = r.username
        points.text = String(r.points)
    }
    
}
