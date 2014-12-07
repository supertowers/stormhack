//
//  StormAPI.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class StormAPI: NSObject {
    
    class func loginWithToken(token: FBAccessTokenData) {

        var params = [
                        "access_token": token
                     ]
        
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.MutableLeaves)
        manager.requestSerializer = AFJSONRequestSerializer(writingOptions: NSJSONWritingOptions.allZeros)
        manager.securityPolicy = AFSecurityPolicy.defaultPolicy()
        manager.requestSerializer.timeoutInterval = 30
        manager.requestSerializer.HTTPShouldHandleCookies = true
        
        manager.POST("http://www.stormhack.net/user/facebook_access", parameters: params, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            
            println(result)
            //OK
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            //KO
        }

    }
    
    class func getProjectList(success:(Array<Project>)->Void) {
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.MutableLeaves)
        manager.requestSerializer = AFJSONRequestSerializer(writingOptions: NSJSONWritingOptions.allZeros)
        manager.securityPolicy = AFSecurityPolicy.defaultPolicy()
        manager.requestSerializer.timeoutInterval = 30
        manager.requestSerializer.HTTPShouldHandleCookies = true
        
        manager.GET("http://www.stormhack.net/sites", parameters: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            println(result)
            
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            
        }
    }
    
    class func getRankingList(success:(Array<Ranking>)->Void) {
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.MutableLeaves)
        manager.requestSerializer = AFJSONRequestSerializer(writingOptions: NSJSONWritingOptions.allZeros)
        manager.securityPolicy = AFSecurityPolicy.defaultPolicy()
        manager.requestSerializer.timeoutInterval = 30
        manager.requestSerializer.HTTPShouldHandleCookies = true
        
        manager.GET("", parameters: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
        }
    }
    
    class func getActivityList(success:(Array<Activity>)->Void) {
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.MutableLeaves)
        manager.requestSerializer = AFJSONRequestSerializer(writingOptions: NSJSONWritingOptions.allZeros)
        manager.securityPolicy = AFSecurityPolicy.defaultPolicy()
        manager.requestSerializer.timeoutInterval = 30
        manager.requestSerializer.HTTPShouldHandleCookies = true
        
        manager.GET("", parameters: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
        }
    }
    
}
