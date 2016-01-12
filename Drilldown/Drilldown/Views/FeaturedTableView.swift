//
//  FeaturedTableView.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 11.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import UIKit

class FeaturedTableView: UITableViewController {
    
    
    let tableData = [
        [
            ["Name": "Wired 1", "Meta": "Subtitle"],
            ["Name": "Wired 2", "Meta": "Subtitle"],
            ["Name": "Wired 3", "Meta": "Subtitle"],
            ["Name": "Wired 4", "Meta": "Subtitle"],
            ["Name": "Wired 5", "Meta": "Subtitle"]
        ],
        [
            ["Name": "TechCrunch 1", "Meta": "Subtitle"],
            ["Name": "TechCrunch 2", "Meta": "Subtitle"],
            ["Name": "TechCrunch 3", "Meta": "Subtitle"],
            ["Name": "TechCrunch 4", "Meta": "Subtitle"],
            ["Name": "TechCrunch 5", "Meta": "Subtitle"]
        ],
        [
            ["Name": "Engadget 1", "Meta": "Subtitle"],
            ["Name": "Engadget 2", "Meta": "Subtitle"],
            ["Name": "Engadget 3", "Meta": "Subtitle"],
            ["Name": "Engadget 4", "Meta": "Subtitle"],
            ["Name": "Engadget 5", "Meta": "Subtitle"]
        ]
    ]
    
    let tableSections = ["Wired", "TechCrunch", "Engadget"]
    

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
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return tableSections.count
        
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData[section].count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FeaturedCell", forIndexPath: indexPath)

        cell.textLabel?.text = tableData[indexPath.section][indexPath.row]["Name"]
        cell.detailTextLabel?.text = tableData[indexPath.section][indexPath.row]["Meta"]

        return cell
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return tableSections[section]
        
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
