//
//  FlightTableViewController.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 3/27/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class FlightTableViewController: UITableViewController {

    var urlFlightString:String!
    var flights: [Flight] = []
    var count : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: urlFlightString)
        println(url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error-> Void in
            if error != nil {
                println(error)
            }else{
                let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
//                println(jsonResult)
                if let transformJson = jsonResult as? NSDictionary {
                    if let departures = transformJson["departures"] as? NSDictionary {
//                        println(departures)
                        if let result = departures["result"] as? NSArray{
                            //println(result)
                            for flight in result {
                                self.count++
                                if let flightObject = flight as? NSDictionary {
                                    var data = Flight(data: flightObject)
                                    self.flights.append(data)
//                                    if let airlines_name = flightObject["airlines_name"] as? String {
//                                        self.flights.append(airlines_name)
//                                    }
                                }
                                
                            }
                            //println(self.count)
                        }
                    }
                }
                //println(self.kotaAsal)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
        task.resume()
        
        /*end get flight*/
        
        
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return flights.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("flight", forIndexPath: indexPath) as FlightTableViewCell

        // Configure the cell...
        let index = flights[indexPath.row]
        cell.maskapaiLabel.text = index.airlines_name
        cell.jamLabel.text = index.simple_departure_time + " - " + index.simple_arrival_time
        cell.hargaLabel.text = "Rp. " + index.price_value
        return cell
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
