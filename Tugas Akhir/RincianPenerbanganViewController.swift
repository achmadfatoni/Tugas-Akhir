//
//  RincianPenerbanganViewController.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 4/1/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class RincianPenerbanganViewController: UIViewController {
    
    var flight : Flight!
    var passengers : Passenger!
    

    @IBOutlet weak var arrivalAirport: UILabel!
    @IBOutlet weak var airlinesName: UILabel!
    @IBOutlet weak var departureAirportLabel: UILabel!
    
    
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    @IBAction func btnPesan(sender: AnyObject) {
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
        
        //println(self.airlinesName.text)
        //println(self.flight.airlines_name)
        
        //set label value
        self.airlinesName?.text = flight.airlines_name
        self.arrivalAirport?.text = flight.arrival_city_name
        self.departureAirportLabel?.text = flight.departure_city_name
        self.departureTimeLabel?.text = flight.simple_departure_time
        self.arrivalTimeLabel?.text = flight.simple_arrival_time
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
