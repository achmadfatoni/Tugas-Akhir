//
//  PassengerDetail.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 4/5/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import Foundation

class PassengerDetail {
    var id : String!
    var title : String!
    var firstName : String!
    var lastName : String!
    var birthDate : String!
    
    init(id : String, title : String, firstName : String, lastName : String, birthDate : String){
        self.id = id
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
    
}