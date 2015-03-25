//
//  TiketAPI.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 3/23/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import Foundation

class TiketAPI {
    
    init(){
        
    }
    
    var secretKey = "64de419c65901078dc7d026194357579"
    
//    var token:String!
    
    func getToken() -> String {
        var token:String = appData.token
        let url = NSURL(string: "http://api.sandbox.tiket.com/apiv1/payexpress?method=getToken&secretkey=64de419c65901078dc7d026194357579&output=json")
        
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error-> Void in
            if error != nil {
                println(error)
            }else{
                let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
                //                println(jsonResult)
                token = jsonResult["token"] as String
                println(token)
            }
            
        })
        task.resume()
        
        return token
        
    }
}
