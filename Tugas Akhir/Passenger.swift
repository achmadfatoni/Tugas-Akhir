//
//  Passenger.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 4/1/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import Foundation

class Passenger{

    var adult:Int!
    var child:Int!
    var infant:Int!
    
    init(data : NSDictionary){
        self.adult = strToInt(data, key: "adult")
        self.adult = strToInt(data, key: "child")
        self.infant = strToInt(data, key: "infant")
    }
    
    func strToInt(data : NSDictionary, key : String) -> Int {
        if let passengers = data[key] as? String {
            var data:Int = passengers.toInt()!
            return data
        }
        
        return 0
    }
}