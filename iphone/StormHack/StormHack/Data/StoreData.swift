//
//  StoreData.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class StoreData: NSObject {
   
    class func saveUserData(user: User) {
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(user.id, forKey: "id")
        defaults.setObject(user.username, forKey: "username")
        defaults.setObject(user.avatarURL, forKey: "avatarURL")
        defaults.setObject(user.email, forKey: "email")
    }
    
    class func getUserData() -> User {
        var user: User = User()
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        user.id = defaults.integerForKey("id")
        user.username = defaults.stringForKey("username")
        user.avatarURL = defaults.stringForKey("avatarURL")
        user.email = defaults.stringForKey("email")
        
        return user
    }
    
    class func deleteUserData() {
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let bundle:String = NSBundle.mainBundle().bundleIdentifier!
        defaults.removePersistentDomainForName(bundle)
    }
    
}
