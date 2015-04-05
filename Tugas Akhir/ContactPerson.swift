//
//  ContactPerson.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 4/2/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import Foundation

class ContactPerson{
    var salutation: String!
    var firstName: String!
    var lastName: String!
    var phone: String!
    var emailAddress: String!
    
    init(salutation: String, firstName: String, lastName: String, phone: String, emailAddress: String){
        self.salutation = salutation
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.emailAddress = emailAddress
    }
}