//
//  ConstraintsHelper.swift
//  StartupLogoQuiz
//
//  Created by Selene Pinillos Franco on 01/08/2014.
//  Copyright (c) 2014 Mothhunters. All rights reserved.
//

import UIKit

class ConstraintsHelper: NSObject {
    class func setConstraints(constraints c: NSArray, views v: NSDictionary, inView iv: UIView) {
        
        for i in c {
            iv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(i as NSString, options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: v))
        }

    }
}
