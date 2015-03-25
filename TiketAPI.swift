//
//  TiketAPI.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 3/25/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import Foundation

class TiketAPI {
    
    init() {
        
    }
    
    func getToken() -> String {
        if appData.token == "" {
            let url = NSURL(string: appData.tiketCom + "apiv1/payexpress?method=getToken&secretkey=" + appData.secretKey + ""  + appData.outputJson)
            
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithURL(url!, completionHandler: {
                data, response, error-> Void in
            
                    if error != nil {
                        println(error)
                    }else{
                        let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
                        appData.token = jsonResult["token"] as String
                    }
                
            })
            task.resume()
            
        }
        return appData.token
    }
    
    func getAirports(token:String) -> [String]{
        
        
        let url = NSURL(string: appData.tiketCom + "flight_api/all_airport?token=" + token + ""  + appData.outputJson)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error-> Void in
            if error != nil {
                println(error)
            }else{
                let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
                if let transformJson = jsonResult as? NSDictionary {
                    if let allAirport = transformJson["all_airport"] as? NSDictionary {
                        if let airports = allAirport["airport"] as? NSArray {
                            for airport in airports {
                                if let locationName = airport["location_name"] as? String{
                                    appData.airports.append(locationName)
                                }
                            }
                            
                        }
                    }
                }
            }
            
        })
        task.resume()
        return appData.airports
    }
}