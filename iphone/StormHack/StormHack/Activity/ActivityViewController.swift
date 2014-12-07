//
//  ActivityViewController.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class ActivityViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataArray: Array<Activity>?
    var tv: AAPullToRefresh?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.setup()
        self.setupPullToRefresh()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func getList() {
        StormAPI.getActivityList({ (array:Array<Activity>) -> Void in
            self.dataArray = array
            self.tableView.reloadData()
            self.tv?.stopIndicatorAnimation()
        })
    }
    
    internal func setupPullToRefresh() {
        tv = (self.tableView as UIScrollView).addPullToRefreshPosition(AAPullToRefreshPosition.Top, actionHandler: { (v: AAPullToRefresh!) -> Void in
            self.getList()
            v.stopIndicatorAnimation()
        });
    }
    
    internal func setup() {
        
        dataArray = Array<Activity>()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var a:Activity = dataArray![indexPath.row]
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("ActivityViewCell") as ActivityViewCell!
        if cell == nil {
            cell = ActivityViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ActivityViewCell")
        }
        
        cell.setData(a)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("a")
        var a:Activity = dataArray![indexPath.row]
        UIApplication.sharedApplication().openURL(NSURL(string: Appearance.getHostURL() + a.url))
    }
    
override     
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray != nil {
            return dataArray!.count
        } else {
            return 0
        }
    }
override     
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let a: Activity = dataArray![indexPath.row]
        
        var attributes = [
            NSFontAttributeName: UIFont(name: "FontAwesome", size: 15)
        ]
        
        var attr = NSAttributedString(string: a.message, attributes: attributes)
        
        var frame: CGRect = attr.boundingRectWithSize(CGSizeMake(255, 2000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        
        return frame.height + 45
    }
override     
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
override     
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ACTIVIDAD"
    }
    
}
