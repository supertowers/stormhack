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
        
        var r:Ranking = Ranking()
        r.username = "Pablo López Torres"
        r.avatarURL = "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash2/v/t1.0-1/c32.164.513.513/s160x160/575166_3823790881458_742720943_n.jpg?oh=22427aea79cada014559f717d7720fff&oe=54F96B35&__gda__=1426098535_568b8fb7df0bbfa4ab04da9dfc692f0e"
        r.points = 150
        
        dataArray?.append(r)
        
        r = Ranking()
        r.username = "Raúl Marcos Lorenzo"
        r.avatarURL = "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xpa1/v/t1.0-1/p160x160/10698502_10152745772198615_4252626519184685445_n.jpg?oh=7b35c4d8ee127b1fee1598c9e3c02887&oe=54FAD7FC&__gda__=1425981037_b28527ddd9a8d49108e36e8b13076339"
        r.points = 130
        
        dataArray?.append(r)
        
        r = Ranking()
        r.username = "Selene Pinillos Franco"
        r.avatarURL = "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn2/v/t1.0-1/c70.35.440.440/s160x160/9063_10152262201457788_561751306_n.jpg?oh=5018a530e89fccb636573982a35240fc&oe=551001CB&__gda__=1427309534_b1eee55a4dcc99ba34e174360d9c27f3"
        r.points = 120
        
        dataArray?.append(r)
        
        r = Ranking()
        r.username = "Javier Cuevas"
        r.avatarURL = "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfp1/v/t1.0-1/c47.0.160.160/p160x160/10354686_10150004552801856_220367501106153455_n.jpg?oh=6f0e7cae0cd6714f07389e9bab10f4a9&oe=55186249&__gda__=1426275897_0c653a473d7b2ad2ea2324d2f3c3ef73"
        r.points = 100
        
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
