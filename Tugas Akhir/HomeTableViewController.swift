//
//  HomeTableViewController.swift
//  Tugas Akhir
//
//  Created by Achmad Fatoni on 3/23/15.
//  Copyright (c) 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var kotaAsalLabel: UILabel!
    @IBOutlet weak var kotaTujuanLabel: UILabel!
    @IBOutlet weak var tanggalLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //penumpang textField
    @IBOutlet weak var penumpangDewasaTxtField: UITextField!
    @IBOutlet weak var penumpangAnakTxtField: UITextField!
    @IBOutlet weak var penumpangBayiTxtField: UITextField!
    
    
    @IBAction func cariTiketBtn(sender: AnyObject) {
//        http://api-sandbox.tiket.com/search/flight?d=CGK&a=DPS&date=2014-05-25&ret_date=2014-05-30&adult=1&child=0&infant=0&token=626de6cbccc25cf3f7a652fc933e49187efdbc54&v=3&output=xml
        
        
    }
    
    
    @IBAction func didChangeDate(){
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        tanggalLabel.text = dateFormatter.stringFromDate(datePicker.date)
        
        var formatTanggalBerangkat = NSDateFormatter()
        formatTanggalBerangkat.dateFormat = "yyyy-MM-dd"
        self.tanggalKeberangkatan = formatTanggalBerangkat.stringFromDate(datePicker.date)
        println("tanggal Keberangkatan : " + self.tanggalKeberangkatan)
    }
    
    let api = TiketAPI()
    var datePickerHidden = false
    var kotaAsalSelected:Airport!
    var kotaTujuanSelected:Airport!
    var tanggalKeberangkatan : String!
    var urlPath:String!
    
    //penumpang
    var penumpangDewasa : Int!
    var penumpangAnak : Int!
    var penumpangBayi : Int!
    

    override func viewDidLoad() {
        didChangeDate()
        toggleDatePicker()
        self.api.getToken()
        
        penumpangDewasaTxtField.text = "1"
        penumpangAnakTxtField.text = "0"
        penumpangBayiTxtField.text = "0"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleDatePicker() {
        datePickerHidden = !datePickerHidden
        
        // Force table to update its contents
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func selectKotaAsal(segue: UIStoryboardSegue){
        let kotaAsalTableView = segue.sourceViewController as KotaAsalTableViewController
        kotaAsalLabel.text = kotaAsalTableView.kotaAsalSelected.locationName
        self.kotaAsalSelected = kotaAsalTableView.kotaAsalSelected
    }
    
    @IBAction func selectKotaTujuan(segue: UIStoryboardSegue){
        let kotaTujuanTableView = segue.sourceViewController as KotaTujuanTableViewController
        kotaTujuanLabel.text = kotaTujuanTableView.kotaTujuanSelected.locationName
        self.kotaTujuanSelected = kotaTujuanTableView.kotaTujuanSelected
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 2 && indexPath.row == 1 {
            return 0
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section, indexPath.row){
        case (2, 0):
            println("cliked")
            toggleDatePicker()
        default:
            ()
        }
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "getFlight" {
            
            var error = 0
            var message = ""
            
            //alert 
            let alert = UIAlertView()
            alert.title = "Error"
            alert.addButtonWithTitle("Ok")
            
            //set default value

            
            //kota asal tidak boleh kosong
            if kotaAsalSelected == nil {
                error++
                message += "Pilih kota asal, "
            }
            
            //kota tujuan tidak boleh kosong
            if kotaTujuanSelected == nil {
                message += "Pilih kota Tujuan, "
                error++
            }
            
            //validasi penumpang dewasa
            if penumpangDewasaTxtField.text == "" {
                message += "Penumpang dewasa tidak boleh kosong, "
                error++
            }else{
                penumpangDewasa = penumpangDewasaTxtField.text.toInt()
                println(penumpangDewasa)
                if penumpangDewasa > 6 {
                    message += "Penumpang dewasa max : 6, "
                    error++
                }
            }
            
            //validasi penumpang anak
            if penumpangAnakTxtField.text != "" {
                penumpangAnak = penumpangAnakTxtField.text.toInt()
                if penumpangAnak > 6 {
                    message += "Penumpang anak max : 6, "
                    error++
                }
            }
            
            //validasi penumpang bayi
            if penumpangBayiTxtField.text != "" {
                penumpangBayi = penumpangBayiTxtField.text.toInt()
                if penumpangAnak > 6 {
                    message += "Penumpang bayi max : 6"
                    error++
                }
            }
            
            if error != 0 {
                alert.message = message
                alert.show()
                
                println("penumpang dewasa : \(penumpangDewasa)")
                println("penumpang anak (2 - 12th) : \(penumpangAnak)")
                println("penumpang anak ( < 2th) : \(penumpangBayi)")
                
                return false
            }
            
        }
        
        return true
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "getFlight" {
            
            var flightTableViewController = segue.destinationViewController as FlightTableViewController
            flightTableViewController.urlFlightString = appData.tiketCom + "search/flight?d=" + kotaAsalSelected.airportCode + "&a=" + kotaTujuanSelected.airportCode + "&date=" + self.tanggalKeberangkatan + "&adult=\(penumpangDewasa!)&child=\(penumpangAnak!)&infant=\(penumpangBayi!)" + "&token=\(appData.token)" + appData.outputJson
            
        }
        
    }
    

}
