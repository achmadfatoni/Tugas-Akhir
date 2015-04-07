//
//  FlightTableViewController.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 3/27/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class FlightTableViewController: UITableViewController {


    var count : Int = 0
    var flights: [Flight] = []
    var urlFlightString:String!
    var passengers : Passenger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
        
      urlFlightString = "http://api.sandbox.tiket.com/search/flight?d=CGK&a=SUB&date=2015-04-08&adult=1&child=0&infant=0&token=54e337cb5d005f29f42d9a96559a292bdbb448bc&output=json"

        let url = NSURL(string: urlFlightString)
        
        println("------------------------------------")
        println("---------- Get Flight URL ----------")
        println("------------------------------------")
        println(url)
        println("------------------------------------")
        
        
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
                                }
                                
                                if self.count == 0 {
                                    var dummyData = [
                                        "airlines_name" : "Tidak ada data",
                                        "price_value" : "Tidak ada data"
                                    ]
                                    var dataKosong = Flight(data: dummyData)
                                    self.flights.append(dataKosong)
                                }
                                
                            }
                            
                            println("_________________________________________________")
                            println("---------- Jumlah Penerbangan Tersedia ----------")
                            println("_________________________________________________")
                            println(self.flights.count)
                            println("_________________________________________________\n")
                        }
                    }
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
        task.resume()
        
        /*end get flight*/
        
        
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
    

  

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "rincianPenerbangan" {
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                let destinationController = segue.destinationViewController as RincianPenerbanganViewController
                destinationController.flight = self.flights[indexPath.row]
                destinationController.passengers = self.passengers
                //println(self.passengers.adult)
                //println(self.flights[indexPath.row].airlines_name)
            }
        }
    }
    

}
