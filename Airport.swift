//
//  Airport.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 3/25/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import Foundation
class Airport{
    var airportCode:String!
    var airportName:String!
    var countryId:String!
    var locationName:String!
    
        init(data:NSDictionary){
            self.airportCode = getStringFromJson(data, key: "airport_code")
            self.airportName = getStringFromJson(data, key: "airport_name")
            self.countryId = getStringFromJson(data, key: "country_id")
            self.locationName = getStringFromJson(data, key: "location_name")
        }
    
    func getStringFromJson(data : NSDictionary, key: String) -> String {
        let info : AnyObject? = data[key]
        
        if let info = data[key] as? String {
            return info
        }
        
        return ""
    }
}