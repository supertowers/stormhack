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
        urlTitle.font = UIFont(name: "FontAwesome", size: 16)
        urlImage = UIImageView()
        
        urlDescription = UILabel()
        urlDescription.numberOfLines = 0
        urlDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping 
        urlDescription.font = UIFont(name: "FontAwesome", size: 15)
        
        urlTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        urlImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        urlDescription.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        contentView.addSubview(urlTitle)
        contentView.addSubview(urlImage)
        contentView.addSubview(urlDescription)
        
    }
    
    internal func setupConstraints() {
        var constraints = [
                            "V:|-10-[urlImage(50)]",
                            "V:|-10-[urlTitle]-5-[urlDescription]",
                            "H:|-10-[urlImage(50)]-10-[urlTitle]-10-|",
                            "H:[urlImage]-10-[urlDescription]-10-|"
                            ]
        var views = Dictionary<String, UIView>()
        views["urlImage"] = urlImage
        views["urlTitle"] = urlTitle
        views["urlDescription"] = urlDescription
        
        ConstraintsHelper.setConstraints(constraints: constraints, views: views, inView: self.contentView)
        
    }
    
    func setData(p: Project) {
        urlTitle.text = p.name
        urlDescription.text = p.desc
        if p.imageUrl != nil {
            urlImage.sd_setImageWithURL(NSURL(string: p.imageUrl!))
        } else {
            urlImage.image = UIImage(named: "photo.png")
        }
    }

}
