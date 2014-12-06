//
//  ProfileViewController.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var profileView: ProfileView!
    var facebooksView: FacebookView!
    
    var dataArray: Array<Activity>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
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
        
        dataArray = Array<Activity>()
        
        var a:Activity = Activity()
        a.type = Type.Check
        a.message = "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla "
        
        dataArray?.append(a)
        
        a = Activity()
        a.type = Type.Ban
        a.message = "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla "
        
        dataArray?.append(a)
        
        a = Activity()
        a.type = Type.Eye
        a.message = "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla "
        
        dataArray?.append(a)
        
        profileView.activityTable.delegate = self
        profileView.activityTable.dataSource = self
        profileView.activityTable.reloadData()
        
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
                FBSession.setActiveSession(session)
                self.requestUserData()
                break
            case FBSessionState.CreatedTokenLoaded:
                FBSession.setActiveSession(session)
                self.requestUserData()
                break
        
            case FBSessionState.Created:
                FBSession.setActiveSession(session)
                self.requestUserData()
                break
                
            case FBSessionState.OpenTokenExtended:
                FBSession.setActiveSession(session)
                self.requestUserData()
                break
            
            case FBSessionState.CreatedOpening:
                FBSession.activeSession().closeAndClearTokenInformation()
                break
             
            case FBSessionState.ClosedLoginFailed:
                FBSession.activeSession().closeAndClearTokenInformation()
                break
            case FBSessionState.Closed:
                FBSession.activeSession().closeAndClearTokenInformation()
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var a:Activity = dataArray![indexPath.row]
        
        var cell = profileView.activityTable.dequeueReusableCellWithIdentifier("ActivityViewCell") as ActivityViewCell!
        if cell == nil {
            cell = ActivityViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ActivityViewCell")
        }
        
        cell.setData(a)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var a: Activity = dataArray![indexPath.row]
        
        var attributes = [
            NSFontAttributeName: UIFont(name: "FontAwesome", size: 15)
        ]
        
        var attr = NSAttributedString(string: a.message, attributes: attributes)
        
        var frame: CGRect = attr.boundingRectWithSize(CGSizeMake(255, 2000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        
        return frame.height + 20
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ACTIVIDAD"
    }

    
}