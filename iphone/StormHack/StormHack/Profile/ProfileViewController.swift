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
    var tv: AAPullToRefresh?
    
    var dataArray: Array<Activity>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.setViews()
        self.checkFB()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
            self.getList()
        } else {
            setupFBView()
        }
    }
    
    internal func getList() {
        StormAPI.getActivityList({ (array:Array<Activity>) -> Void in
            self.dataArray = array
            self.profileView.activityTable.reloadData()
            self.tv?.stopIndicatorAnimation()
        })
    }
    
    internal func setViews() {
        facebooksView = FacebookView(frame: self.view.bounds)
        profileView = ProfileView(frame: self.view.bounds)
        setupFBTargets()
        setupProfileTargets()
        setupPullToRefresh()
    }
    
    internal func setupPullToRefresh() {
        tv = (profileView.activityTable as UIScrollView).addPullToRefreshPosition(AAPullToRefreshPosition.Top, actionHandler: { (v: AAPullToRefresh!) -> Void in
            self.getList()
            v.stopIndicatorAnimation()
        });
    }
    
    internal func setupFBView() {
        self.view = facebooksView
    }
    internal func setupProfileView() {
        self.view = profileView
        profileView.setData(StoreData.getUserData())
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
        }
    }
    
    internal func requestUserData() {
        StormAPI.loginWithToken(FBSession.activeSession().accessTokenData, success: { (user) -> Void in
            StoreData.saveUserData(user)
            self.setupProfileView()
        })
        
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
        if dataArray != nil {
            return dataArray!.count
        } else {
            return 0
        }
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