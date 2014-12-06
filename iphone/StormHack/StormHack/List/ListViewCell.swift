//
//  ListViewCell.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {

    var urlTitle: UILabel!
    var urlImage: UIImageView!
    var urlDescription: UILabel!
    var reward: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()
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
        
        urlTitle = UILabel()
        urlTitle.font = UIFont.boldSystemFontOfSize(18)
        urlImage = UIImageView()
        
        urlDescription = UILabel()
        urlDescription.numberOfLines = 0
        urlDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping 
        urlDescription.font = UIFont.systemFontOfSize(15)
        
        reward = UILabel()
        reward.font = UIFont.boldSystemFontOfSize(18)
        
        urlTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        urlImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        urlDescription.setTranslatesAutoresizingMaskIntoConstraints(false)
        reward.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        contentView.addSubview(urlTitle)
        contentView.addSubview(urlImage)
        contentView.addSubview(urlDescription)
        contentView.addSubview(reward)
        
    }
    
    internal func setupConstraints() {
        var constraints = [
                            "V:|-10-[urlImage(50)]",
                            "V:|-10-[urlTitle]-5-[urlDescription]",
                            "V:|-10-[reward(50)]",
                            "H:|-10-[urlImage(50)]-10-[urlTitle]-10-[reward(50)]-10-|",
                            "H:[urlImage]-10-[urlDescription]-10-[reward]"
                            ]
        var views = Dictionary<String, UIView>()
        views["urlImage"] = urlImage
        views["urlTitle"] = urlTitle
        views["urlDescription"] = urlDescription
        views["reward"] = reward
        
        ConstraintsHelper.setConstraints(constraints: constraints, views: views, inView: self.contentView)
        
    }
    
    func setData(p: Project) {
        urlTitle.text = p.name
        urlDescription.text = p.desc
        urlImage.sd_setImageWithURL(NSURL(string: p.imageUrl!))
        reward.text = p.reward! + "€"
    }

}
