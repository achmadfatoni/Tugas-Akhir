//
//  KotaAsalTableViewController.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 3/23/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class KotaAsalTableViewController: UITableViewController {
    
    var kotaAsal:[String]! = []
    var kotaAsalSelected:String!
    var api = TiketAPI()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        /* start get airports */
        let url = NSURL(string: appData.tiketCom + "flight_api/all_airport?token=" + appData.token + ""  + appData.outputJson)
        println(url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error-> Void in
            if error != nil {
                println(error)
            }else{
                let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
                if let transformJson = jsonResult as? NSDictionary {
                    if let allAirport = transformJson["all_airport"] as? NSDictionary {
//                        println(allAirport)
                        if let airports = allAirport["airport"] as? NSArray {
                            for airport in airports {
                                if let locationName = airport["location_name"] as? String{
                                    self.kotaAsal.append(locationName)
                                }
                                
                                //println(airport["location_name"])
                            }
                            
                        }
                    }
                }
                println(self.kotaAsal)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                })
        })
        task.resume()
        
        /*end get airports*/
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return kotaAsal.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("KotaAsal", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = kotaAsal[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectKotaAsal" {
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            kotaAsalSelected = kotaAsal[indexPath!.row]
        }
    }
    
    @IBAction func setAirports(segue: UIStoryboardSegue){
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
