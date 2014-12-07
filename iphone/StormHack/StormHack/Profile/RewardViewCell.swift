//
//  RewardViewCell.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 07/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class RewardViewCell: UITableViewCell {
    
    var icon: UIImageView!
    var title: UILabel!
    var desc: UILabel!
    var badge: UILabel!
    var date: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func setupViews() {
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        icon = UIImageView()
        icon.contentMode = UIViewContentMode.ScaleAspectFit
        title = UILabel()
        title.font = UIFont(name: "FontAwesome", size: 15)
        desc = UILabel()
        desc.font = UIFont(name: "FontAwesome", size: 13)
        desc.numberOfLines = 0
        desc.lineBreakMode = NSLineBreakMode.ByCharWrapping
        badge = UILabel()
        badge.font = UIFont(name: "FontAwesome", size: 13)
        badge.textColor = UIColor.whiteColor()
        badge.layer.cornerRadius = 3
        badge.layer.masksToBounds = true
        badge.textAlignment = NSTextAlignment.Center
        date = UILabel()
        date.font = UIFont(name: "FontAwesome", size: 13)
        
        icon.setTranslatesAutoresizingMaskIntoConstraints(false)
        title.setTranslatesAutoresizingMaskIntoConstraints(false)
        desc.setTranslatesAutoresizingMaskIntoConstraints(false)
        badge.setTranslatesAutoresizingMaskIntoConstraints(false)
        date.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(desc)
        contentView.addSubview(badge)
        contentView.addSubview(date)
        
    }
    internal func setConstraints() {
        var constraints = [
                            "V:|-25-[icon(35)]",
                            "V:|-15-[title]-5-[desc]-5-[date]",
                            "V:|-15-[badge(20)]-[desc]",
                            "H:|-15-[icon(35)]-15-[title]-5-[badge(>=40)]",
                            "H:[icon]-15-[desc]-10-|",
                            "H:[icon]-15-[date]-10-|"
                            ]
        
        var views = Dictionary<String, UIView>()
        views["icon"] = icon
        views["title"] = title
        views["desc"] = desc
        views["date"] = date
        views["badge"] = badge
        
        ConstraintsHelper.setConstraints(constraints: constraints, views: views, inView: contentView)
    
    }
    
    func setData(r: Reward) {
        if(r.icon == TypeReward.OK) {
            var ic:FAKFontAwesome = FAKFontAwesome.checkCircleIconWithSize(35)
            ic.addAttribute(NSForegroundColorAttributeName, value: ColorHelper.colorWithHex(0x5cb85c))
            
            icon.image = ic.imageWithSize(CGSizeMake(35,35))
            
            badge.backgroundColor = ColorHelper.colorWithHex(0x5cb85c)
            
        } else {
            var ic:FAKFontAwesome = FAKFontAwesome.banIconWithSize(35)
            ic.addAttribute(NSForegroundColorAttributeName, value: ColorHelper.colorWithHex(0xd9534f))
            
            icon.image = ic.imageWithSize(CGSizeMake(35,35))
            badge.backgroundColor = ColorHelper.colorWithHex(0xd9534f)
        }
        
        title.text = r.title
        desc.text = r.desc
        date.text = FAKFontAwesome.clockOIconWithSize(15).attributedString().string + " " + r.date
        badge.text = r.badge
    }

}
