//
//  ActivityViewCell.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

enum Type {
    case Bug
    case Web
}

class ActivityViewCell: UITableViewCell {
    
    var icon: UIImageView!
    var message: UILabel!
    
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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    internal func setupViews() {
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        icon = UIImageView()
        icon.contentMode = UIViewContentMode.ScaleAspectFit
        
        message = UILabel()
        message.font = UIFont(name: "FontAwesome", size: 15)
        message.numberOfLines = 0
        message.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        icon.setTranslatesAutoresizingMaskIntoConstraints(false)
        message.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        contentView.addSubview(icon)
        contentView.addSubview(message)
    }
    
    internal func setConstraints() {
        var constraints = [
                            "V:|-10-[icon(35)]",
                            "V:|-15-[message]",
                            "H:|-10-[icon(35)]-10-[message]-10-|"
                            ]
        
        var views = Dictionary<String, UIView>()
        views["icon"] = icon
        views["message"] = message
        
        ConstraintsHelper.setConstraints(constraints: constraints, views: views, inView: contentView)
    }
    
    
    func setData(a: Activity) {
        
        if(a.type == Type.Bug) {
            var ic:FAKFontAwesome = FAKFontAwesome.bugIconWithSize(35)
            ic.addAttribute(NSForegroundColorAttributeName, value: ColorHelper.colorWithHex(0xd9534f))
            
            icon.image = ic.imageWithSize(CGSizeMake(35,35))
        } else if (a.type == Type.Web) {
            var ic:FAKFontAwesome = FAKFontAwesome.eyeIconWithSize(35)
            ic.addAttribute(NSForegroundColorAttributeName, value: ColorHelper.colorWithHex(0x428bca))
            
            icon.image = ic.imageWithSize(CGSizeMake(35,35))
        }
        
        
        message.text = a.message
    }

}
