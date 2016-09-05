//
//  ViewController.swift
//  teratail_46871
//
//  Created by KentarOu on 2016/09/06.
//  Copyright © 2016年 KentarOu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray: [DataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray = DataBaseManager.sharedInstance.selectRecipeAllData()
        
        tableView.estimatedRowHeight = 20
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - TableView Delegate & DataSource
    
    // Row Count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // Generate Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row].jpn
        return cell
    }
    
    // Select Cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("toDetail", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detail = segue.destinationViewController as? DetailViewController {
            detail.index = sender as! Int
            detail.data = dataArray
        }
    }
}
