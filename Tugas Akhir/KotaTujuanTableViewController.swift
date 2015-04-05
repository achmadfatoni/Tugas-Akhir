//
//  KotaTujuanTableViewController.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 3/26/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class KotaTujuanTableViewController: UITableViewController {
    
    var kotaTujuan:[Airport]! = []
    var kotaTujuanSelected:Airport!
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
                                //                                println(airport)
                                let airportObject = Airport(data: airport as NSDictionary)
                                self.kotaTujuan.append(airportObject)
                            }
                            
                        }
                    }
                }
                //                println(self.kotaAsal)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
        task.resume()
        
        /*end get airports*/
        
        //set back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
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
        return kotaTujuan.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("KotaTujuan", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = kotaTujuan[indexPath.row].locationName
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectKotaTujuan" {
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            kotaTujuanSelected = kotaTujuan[indexPath!.row]
        }
    }
    

}
