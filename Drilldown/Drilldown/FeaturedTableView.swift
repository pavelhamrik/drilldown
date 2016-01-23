//
//  FeaturedTableView.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 11.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import UIKit
import DrilldownData
import CoreData

class FeaturedTableView: UITableViewController {
    
    
    @IBOutlet weak var featuredTable: UITableView!
    
    var articles = [NSManagedObject]()
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        articles = DrilldownData.load("Article", limit: 30)
        
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // Hide separators for empty rows
        self.tableView.tableFooterView = UIView()
        
        // Pull to refresh handler
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fancyReloadData() {
    
        featuredTable.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
    
    }
    
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        reloadArticles(self)
        refreshControl.endRefreshing()
    
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = featuredTable.dequeueReusableCellWithIdentifier("FeaturedCell", forIndexPath: indexPath)
        let article = articles[indexPath.row]
        
        //cell.setValue(article.valueForKey("url"), forUndefinedKey: "cellID")
        cell.textLabel?.text = article.valueForKey("title") as? String
        cell.detailTextLabel?.text = (article.valueForKey("source") as? String)! + " \u{2022} " + DateHelpers.dateToString(article.valueForKey("date") as! NSDate, dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.ShortStyle)

        return cell
        
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
        
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        featuredTable.beginUpdates()
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let itemToDelete = articles[indexPath.row]
            
            if let url = itemToDelete.valueForKey("url") as? String {
                if DrilldownData.deleteObject("Article", objectIDName: "url", objectID: url) {
                    featuredTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    articles.removeAtIndex(indexPath.row)
                }
            }
            
        }
        
        featuredTable.endUpdates()
        
    }
    
    
    @IBAction func reloadArticles(sender: AnyObject) {
        
        Communication.reloadArticles()
        articles = DrilldownData.load("Article")
        self.fancyReloadData()
        
    }
    
    
    @IBAction func clearArticles(sender: AnyObject) {
        
        DrilldownData.deleteObjects("Article")
        articles = DrilldownData.load("Article")
        self.fancyReloadData()
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
