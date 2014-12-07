//
//  ParseResponse.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 07/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class ParseResponse: NSObject {
    class func parseUser(response: AnyObject!) -> User {
        let user:User = User()
        user.id = response["id"] as Int
        user.username = response["name"] as String
        user.avatarURL = response["image"] as? String
        user.email = response["email"] as String
        user.score = response["score"] as Int
        return user
    }
    
    class func parseProjects(response: AnyObject!) -> Array<Project> {
    
        var projects = Array<Project>()
        
        let array = response as Array<AnyObject>
        for dict in array {
            var p:Project = Project()
            p.name = dict["url"] as String
            p.desc = dict["public_description"] as String
            p.imageUrl = dict["snapshot"] as? String
            projects.append(p)
        }
        
        return projects
    }
    
    class func parseActivities(response: AnyObject!) -> Array<Activity> {
        
        var activities = Array<Activity>()
        
        let array = response as Array<AnyObject>
        for dict in array {
            var a:Activity = Activity()
            a.message = dict["activity"] as String
            a.type = Type.Web
            a.url = dict["url"] as String
            activities.append(a)
        }
        
        return activities
    }
    
}
