//
//  FacebookView.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class FacebookView: UIView {

    var facebookButton: UIButton!
    var text: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupViews() {
        
        facebookButton = UIButton()
        facebookButton.setBackgroundImage(ColorHelper.imageFromHex(0x3B5998), forState: UIControlState.Normal)
        facebookButton.setTitle("Login con Facebook", forState: UIControlState.Normal)
        facebookButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        facebookButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(facebookButton)
    }
    
    internal func setupConstraints() {
        var constraints = [
            "V:[facebookButton(50)]-80-|",
            "H:|-30-[facebookButton]-30-|"
        ]
        var views = Dictionary<String, UIView>()
        views["facebookButton"] = facebookButton
        
        ConstraintsHelper.setConstraints(constraints: constraints, views: views, inView: self)
    }

}
