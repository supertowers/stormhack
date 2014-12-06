//
//  ProfileViewController.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileView: ProfileView!
    var facebooksView: FacebookView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkFB()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func setupFBTargets() {
        facebooksView.facebookButton.addTarget(self, action: "loginWithFacebook", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    internal func setupProfileTargets() {
        profileView.logoutButton.addTarget(self, action: "logout", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    internal func checkFB() {
        var session:FBSession = FBSession.activeSession()
        if session.accessTokenData != nil {
            setupProfileView()
        } else {
            setupFBView()
        }
    }
    
    internal func setupFBView() {
        facebooksView = FacebookView(frame: self.view.bounds)
        self.view = facebooksView
        setupFBTargets()
    }
    internal func setupProfileView() {
        profileView = ProfileView(frame: self.view.bounds)
        self.view = profileView
        profileView.setData(StoreData.getUserData())
        setupProfileTargets()
    }
    
    internal func loginWithFacebook() {
        FBSession.openActiveSessionWithReadPermissions(["public_profile", "email"], allowLoginUI: true) { (session:FBSession!, state: FBSessionState, error: NSError!) -> Void in
            
            switch(state) {
            case FBSessionState.Open:
                println("open")
                FBSession.setActiveSession(session)
                self.requestUserData()
                break
            case FBSessionState.CreatedTokenLoaded:
                println("token")
                FBSession.setActiveSession(session)
                self.requestUserData()
                break
        
            case FBSessionState.Created:
                println("created")
                FBSession.setActiveSession(session)
                self.requestUserData()
                break
                
            case FBSessionState.OpenTokenExtended:
                println("extended")
                FBSession.setActiveSession(session)
                self.requestUserData()
                break
            
            case FBSessionState.CreatedOpening:
                FBSession.activeSession().closeAndClearTokenInformation()
                println("opening")
                break
             
            case FBSessionState.ClosedLoginFailed:
                FBSession.activeSession().closeAndClearTokenInformation()
                println("failed")
                break
            case FBSessionState.Closed:
                FBSession.activeSession().closeAndClearTokenInformation()
                println("closed")
                break
                
            default:
                break
            }
            
            //access token, picture, name, id, expire
        }
    }
    
    internal func requestUserData() {
        
        FBRequestConnection.startWithGraphPath("/me", parameters: ["fields": "id, name, picture, email"], HTTPMethod: "GET", completionHandler: { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            
            
            var user = result as FBGraphObject
            self .setUser(user)
        })
    }
    
    internal func setUser(fbUser: FBGraphObject) {
        var user:User = User()
        
        user.id = fbUser["id"] as String
        user.username = fbUser["name"] as String
        user.avatarURL = "https://graph.facebook.com/" + (fbUser["id"] as String) + "/picture?type=square"
        user.email = fbUser["email"] as String
        StoreData.saveUserData(user)
        self.setupProfileView()
    }
    
    internal func logout() {
        FBSession.activeSession().close()
        FBSession.activeSession().closeAndClearTokenInformation()
        StoreData.deleteUserData()
        setupFBView()
    }
    
}