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
    
    var departure_city_name: String!
    var arrival_city_name: String!
    
    init(data:NSDictionary){
        self.airlines_name = getStringFromJson(data, key: "airlines_name")
        self.price_value = getStringFromJson(data, key: "price_value")
        self.simple_departure_time = getTime(data, key: "simple_departure_time")
        self.simple_arrival_time = getTime(data, key: "simple_arrival_time")
        self.departure_city_name = getCity(data, key: "departure_city_name")
        self.arrival_city_name = getCity(data, key: "arrival_city_name")
    }
    
    func getStringFromJson(data : NSDictionary, key: String) -> String {
        let info : AnyObject? = data[key]
        
        if let info = data[key] as? String {
            return info
        }
        
        return ""
    }
    
    func getTime(data : NSDictionary, key : String) -> String {
        
        if let flight_infos = data["flight_infos"] as? NSDictionary {
            if let flight_info = flight_infos["flight_info"] as? NSArray {
                if let time = flight_info[0][key] as? String {
                    return time
                }
            }
        }
        
        return ""
    }
    
    func getCity(data : NSDictionary, key: String) -> String {
        if let city = data[key] as? String {
            return city
        }
        
        return ""
    }
}