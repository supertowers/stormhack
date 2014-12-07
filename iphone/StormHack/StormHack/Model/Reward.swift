//
//  Reward.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 07/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

enum TypeReward{
    case OK
    case KO
}

class Reward: NSObject {
    var title: String!
    var desc: String!
    var icon: TypeReward!
    var date: String!
    var badge: String!
}
