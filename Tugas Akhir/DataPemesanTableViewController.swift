//
//  DataPemesanTableViewController.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 4/2/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class DataPemesanTableViewController: UITableViewController {

    @IBOutlet weak var salutation: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var contactPerson : ContactPerson!
    var passengers : Passenger!
    var flight : Flight!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //remove separator
        self.tableView.separatorColor = UIColor.whiteColor()
        
        //remove extra separator
        self.tableView.tableFooterView = UIView(frame:
            CGRectZero)
        
        //set back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        
        //dummy data pemesan
        salutation.text = "mr"
        firstName.text = "achmad"
        lastName.text = "fatoni"
        phone.text = "081515339555"
        email.text = "achmadfaton@gmail.com"
        
        
        var error = 0
        var message = ""
        
        //alert
        let alert = UIAlertView()
        alert.title = "Error"
        alert.addButtonWithTitle("Ok")
        
        
        
        //titel tidak boleh kosong
        if salutation.text == "" {
            error++
            message += "Isi titel !, "
        }
        
        //nama depan tidak boleh kosong
        if firstName.text == "" {
            message += "Isi nama depan !,  "
            error++
        }
        
        if lastName.text == "" {
            message += "Nama belakang tidak boleh kosong !, "
            error++
        }
        
        if phone.text == "" {
            message += "Nomor telepon tidak boleh kosong !"
            error++
        }
        
        if email.text == "" {
            message += "Email tidak boleh kosong !"
            error++
        }
        
        
        if error != 0 {
            alert.message = message
            alert.show()
            
            
            return false
        }
        
        contactPerson = ContactPerson(salutation: salutation.text, firstName: firstName.text, lastName: lastName.text, phone: phone.text, emailAddress: email.text)
        
        println("------------------------------------")
        println("---------- Contact Person ----------")
        println("------------------------------------")
        println("salutation     : " + contactPerson.salutation)
        println("firstname      : " + contactPerson.firstName)
        println("lastname       : " + contactPerson.lastName)
        println("phone          : " + contactPerson.phone)
        println("email address  : " + contactPerson.emailAddress)
        println("------------------------------------")
        return true
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destionationControler = segue.destinationViewController as DataPenumpangTableViewController
        destionationControler.contactPerson = self.contactPerson
        destionationControler.passengers = self.passengers
        destionationControler.flight = self.flight
    }



}
