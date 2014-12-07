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
        var cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(response.allHeaderFields, forURL: NSURL(string: ""))
        var cookieHeaders: [NSObject : AnyObject] = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
    
        for key in cookieHeaders.keys {
            println(key)
        }
        
       // NSUserDefaults.standardUserDefaults().setObject(cookieHeaders[cookieHeaders.keys[0]], forKey: "Cookie")

    }
    
    class func getCookie() -> NSHTTPCookie {
        return NSUserDefaults.standardUserDefaults().objectForKey("Cookie") as NSHTTPCookie
    }
}
