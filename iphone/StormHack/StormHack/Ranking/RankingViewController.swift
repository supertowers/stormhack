//
//  RankingViewController.swift
//  StormHack
//
//  Created by Selene Pinillos Franco on 06/12/2014.
//  Copyright (c) 2014 Selene Pinillos Franco. All rights reserved.
//

import UIKit

class RankingViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataArray: Array<Ranking>?
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
        StormAPI.getRankingList({ (array:Array<Ranking>) -> Void in
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
        
        dataArray = Array<Ranking>()
        
        let r = Ranking()
        r.username = "Username"
        r.avatarURL = "http://images.nigms.nih.gov/images/dulles_th.jpg"
        r.points = 50
        
        dataArray?.append(r)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var r: Ranking = dataArray![indexPath.row]
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("RankingViewCell") as RankingViewCell!
        
        if cell == nil {
            cell = RankingViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "RankingViewCell")
        }
        cell.setData(r)
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //TODO
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray != nil {
            return dataArray!.count
        } else {
            return 0
        }
    }
    
}
