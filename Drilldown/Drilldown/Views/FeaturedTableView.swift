//
//  FeaturedTableView.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 11.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import UIKit
import CoreData

class FeaturedTableView: UITableViewController {
    
    
    @IBOutlet weak var featuredTable: UITableView!
    
    var articles = [NSManagedObject]()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        articles = CoreDataHelpers.load("Article")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Communication.sources.count
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tableData[section].count
        return articles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeaturedCell", forIndexPath: indexPath)
        let article = articles[indexPath.row]
        
        cell.textLabel?.text = article.valueForKey("title") as? String
        cell.detailTextLabel?.text = article.valueForKey("source") as? String

        return cell
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Communication.sources[section]
    }
    
    
    @IBAction func reloadArticles(sender: AnyObject) {
        Communication.reloadArticles()
    }
    
    
    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New Article",
            message: "Add something here",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
                
                let textField = alert.textFields!.first
                let textField2 = alert.textFields![1]
                self.saveArticle(textField!.text!, source: textField2.text!)
                self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        alert.addTextFieldWithConfigurationHandler {
            (textField2: UITextField) -> Void in
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func saveArticle(title: String, source: String) {
        let data = ["title": title, "source": source]
        CoreDataHelpers.save("Article", values: data)
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
