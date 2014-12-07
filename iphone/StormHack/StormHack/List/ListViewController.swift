//
//  ListViewController.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    var dataArray: Array<Project>?
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
    
    internal func getList() {
        StormAPI.getProjectList({ (array:Array<Project>?) -> Void in
            if array != nil {
                self.dataArray = array
                self.tableView.reloadData()
                self.tv?.stopIndicatorAnimation()
            }
        })
    }
    
    internal func setupPullToRefresh() {
        tv = (self.tableView as UIScrollView).addPullToRefreshPosition(AAPullToRefreshPosition.Top, actionHandler: { (v: AAPullToRefresh!) -> Void in
            self.getList()
        });
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func setup() {
        
        dataArray = Array<Project>()
        /*
        let p = Project()
        p.name = "title"
        p.desc = "description d d d asoidj aoid aoi doisa dasid oias doiasudoiadu oai udoiadoisaud ois"
        p.imageUrl = "http://images.nigms.nih.gov/images/dulles_th.jpg"
        p.reward = "5"
        
        dataArray?.append(p)
        */
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let p: Project = dataArray![indexPath.row]
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("ListViewCell") as ListViewCell!
        
        if cell == nil {
            cell = ListViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ListViewCell")
        }
        
        cell.setData(p)
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //PROJECT DETAILS ????
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let p: Project = dataArray![indexPath.row]
        
        var attributes = [
            NSFontAttributeName: UIFont(name: "FontAwesome", size: 12)
        ]
        
        var attr = NSAttributedString(string: p.desc!, attributes: attributes)
        
        var frame: CGRect = attr.boundingRectWithSize(CGSizeMake(180, 2000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        
        return frame.height + 50
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray != nil {
            return dataArray!.count
        } else {
            return 0
        }
    }
}