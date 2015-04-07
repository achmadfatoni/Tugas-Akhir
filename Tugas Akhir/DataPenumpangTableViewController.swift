//
//  DataPenumpangTableViewController.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 4/2/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class DataPenumpangTableViewController: UITableViewController {
    
    var contactPerson : ContactPerson!
    var passengers : Passenger!
    var datePickerHidden = false
    var birthDate : String!
    var flight : Flight!

    @IBOutlet weak var IdPassengerTextField: UITextField!
    @IBOutlet weak var titlePassngerTextField: UITextField!
    @IBOutlet weak var firstNamePassengerTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func didChangeDate(){
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        birthDateLabel.text = dateFormatter.stringFromDate(datePicker.date)
        
        var birthDateFormatter = NSDateFormatter()
        birthDateFormatter.dateFormat = "yyyy-MM-dd"
        birthDate = birthDateFormatter.stringFromDate(datePicker.date)
    }
    
    
    func toggleDatePicker() {
        datePickerHidden = !datePickerHidden
        
        // Force table to update its contents
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 0 && indexPath.row == 5 {
            return 0
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section, indexPath.row){
        case (0, 4):
            toggleDatePicker()
        default:
            ()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //remove separator
        self.tableView.separatorColor = UIColor.whiteColor()
        
        //remove extra separator
        self.tableView.tableFooterView = UIView(frame:
            CGRectZero)
        didChangeDate()
        toggleDatePicker()

        //set back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {

        
        var error = 0
        var message = ""
        
        //alert
        let alert = UIAlertView()
        alert.title = "Error"
        alert.addButtonWithTitle("Ok")
        
        
        
        //ID tidak boleh kosong
        if IdPassengerTextField.text == "" {
            error++
            message += "ID Harus diisi !, "
        }
        
        //title tidak boleh kosong
        if titlePassngerTextField.text == "" {
            error++
            message += "Title harus diisi !"
        }
        
        //nama depan tidak boleh kosong
        if firstNamePassengerTextField.text == "" {
            message += "Nama Depan harus diisi !,  "
            error++
        }
        
        if lastNameTextField.text == "" {
            message += "Nama belakang harus diisi !, "
            error++
        }
        

        
        
        if error != 0 {
            alert.message = message
            alert.show()
            
            
            return false
        }
        
        
        println("\n------------------------------------")
        println("---------- Add Order ----------")
        println("------------------------------------")
        println("token              : " + appData.token)
        println("flight_id          : " + self.flight.flight_id)
        println("adult              : \(self.passengers.adult)")
        println("child              : \(self.passengers.child)")
        println("conSalutation      : " + self.contactPerson.salutation)
        println("conFirstName       : " + self.contactPerson.firstName)
        println("conLastName        : " + self.contactPerson.lastName)
        println("conPhone           : " + self.contactPerson.phone)
        println("conEmailAddress    : " + self.contactPerson.emailAddress)
        println("------------------------------------")

        
        
        
//        /* start get airports */
//        var urlString = appData.tiketCom + "order/add/flight?token=" + appData.token + ""  + appData.outputJson
//        let url = NSURL(string: urlString)
//        println("Url get airports : " + urlString)
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error-> Void in
//            if error != nil {
//                println(error)
//            }else{
//                let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
//                println(jsonResult)
//            }
//            
//        })
//        task.resume()
        
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }


}
