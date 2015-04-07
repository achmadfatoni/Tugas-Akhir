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
            
            var urlString = appData.tiketCom + "apiv1/payexpress?method=getToken&secretkey=" + appData.secretKey + ""  + appData.outputJson
            let url = NSURL(string: urlString)
            
            println("\n-------------------------------------")
            println("---------- URL GET Token ----------")
            println("-------------------------------------\n")
            println(urlString)
            println("-------------------------------------\n")
            
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithURL(url!, completionHandler: {
                data, response, error-> Void in
            
                    if error != nil {
                        println(error)
                    }else{
                        let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
                        appData.token = jsonResult["token"] as String
                        
                        println("\n-------------------------------------")
                        println("---------- Token ----------")
                        println("-------------------------------------\n")
                        println(appData.token)
                        println("-------------------------------------\n")
                    }
                
            })
            task.resume()
            
        }
        return appData.token
    }
    
}