//
//  Flight.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 3/30/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import Foundation

class Flight {
    var airlines_name: String!
    var price_value: String!
    var simple_departure_time: String!
    var simple_arrival_time: String!
    init(data:NSDictionary){
        self.airlines_name = getStringFromJson(data, key: "airlines_name")
        self.price_value = getStringFromJson(data, key: "price_value")
        self.simple_departure_time = getTime(data, key: "simple_departure_time")
        self.simple_arrival_time = getTime(data, key: "simple_arrival_time")
    }
    
    func getStringFromJson(data : NSDictionary, key: String) -> String {
        let info : AnyObject? = data[key]
        
        if let info = data[key] as? String {
            return info
        }
        
        return ""
    }
    
    func getTime(data : NSDictionary, key : String) -> String {
//        let flight_infos : AnyObject? = data["flight_infos"]
        
        if let flight_infos = data["flight_infos"] as? NSDictionary {
            if let flight_info = flight_infos["flight_info"] as? NSArray {
                if let time = flight_info[0][key] as? String {
                    return time
                }
            }
        }
        
        return ""
    }
    
    /*
    "flight_infos": {
    "flight_info": [
    {
    "flight_number": "SJ-268",
    "departure_city": "CGK",
    "arrival_city": "SUB",
    "simple_departure_time": "05:00",
    "simple_arrival_time": "06:15"
    }
    ]
    },
    */
}