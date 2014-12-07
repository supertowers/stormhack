//
//  CookieHelper.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 07/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class CookieHelper: NSObject {
    class func saveCookie(response: NSHTTPURLResponse) {
        var cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(response.allHeaderFields, forURL: NSURL(string: "http://192.168.1.142:3000"))
        var cookieHeaders: [NSObject : AnyObject] = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
    
        for key in cookieHeaders.keys {
            NSUserDefaults.standardUserDefaults().setObject(cookieHeaders[key], forKey: "Cookie")
            println(cookieHeaders[key])
        }

    }
    
    class func getCookie() -> String {
        
        var cookie = NSUserDefaults.standardUserDefaults().stringForKey("Cookie")
        if cookie != nil {
            return cookie!
        }
        
        return ""
        
    }
    
    class func deleteCookie() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Cookie")
    }
}
