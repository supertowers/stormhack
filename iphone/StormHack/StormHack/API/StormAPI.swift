//
//  StormAPI.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class StormAPI: NSObject {
    
    class func loginWithToken(token: FBAccessTokenData, success:(user:User)->Void) {

        var params = [
                        "access_token": token.accessToken
                     ]
        
        getManager().POST("http://192.168.1.142:3000/users/facebook_access", parameters: params, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            
                CookieHelper.saveCookie(operation.response)
                success(user: ParseResponse.parseUser(result))
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error: " + error.localizedDescription)
        }

    }
    
    class func getProjectList(success:(Array<Project>?)->Void) {
        
        let manager: AFHTTPRequestOperationManager = getManager()
        //manager.requestSerializer.setValue(CookieHelper.getCookie(), forHTTPHeaderField: "Cookie")
        
        manager.GET("http://192.168.1.142:3000/sites", parameters: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            
            println(result)
            success(ParseResponse.parseProjects(result))
            
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("error: " + error.localizedDescription)
        }
    }
    
    class func getRankingList(success:(Array<Ranking>)->Void) {
        let manager: AFHTTPRequestOperationManager = getManager()
        manager.requestSerializer.setValue(CookieHelper.getCookie(), forHTTPHeaderField: "Cookie")
        
        manager.GET("", parameters: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
        }
    }
    
    class func getActivityList(success:(Array<Activity>)->Void) {
        let manager: AFHTTPRequestOperationManager = getManager()
        manager.requestSerializer.setValue(CookieHelper.getCookie(), forHTTPHeaderField: "Cookie")
        
        manager.GET("", parameters: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
        }
    }
    
    class func getManager() -> AFHTTPRequestOperationManager {
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.MutableLeaves)
        manager.responseSerializer.acceptableContentTypes = manager.responseSerializer.acceptableContentTypes.setByAddingObject("text/html")
        manager.securityPolicy = AFSecurityPolicy.defaultPolicy()
        
        var request:AFJSONRequestSerializer = AFJSONRequestSerializer()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer = request
        
        manager.requestSerializer.timeoutInterval = 60
        manager.requestSerializer.HTTPShouldHandleCookies = true
        return manager
    }
    
}
