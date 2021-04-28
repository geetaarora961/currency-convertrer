//
//  currencychangeTableViewController.swift
//  Currency Converter(geeta)
//
//  Created by Manjinder Aulakh on 2019-11-10.
//  Copyright © 2019 Manjinder kaur. All rights reserved.
//

import UIKit
//PROTOCOL TO SEND DATA BACK TO VIEWCONTROLLER
protocol goBackDelegate {
    func nameOfCountry(country:String)
    
}
let flags:[UIImage] = [UIImage(named:"USA")!,UIImage(named: "india")!,UIImage(named: "canada")!]

class currencychangeTableViewController: UITableViewController {
    
    
    var dele:goBackDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  currencyDict.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currency")
        
        // CELL HAS BY DEFAULT IMAGEVIEW AND LABEL AND SETTING UP DATA ON THEM IN MAIN THREAD
        DispatchQueue.main.async {
            cell?.imageView?.image = flags[indexPath.row]
            cell?.imageView?.contentMode = .scaleAspectFill
            cell?.textLabel?.text =  currencyDict.allKeys[indexPath.row]as? String
            
        }
        
        
        return cell!
    }
    //METHOD TO ADJUST CELL HEIGHT
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.00
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //USING DELEGATE CALLING DELEGATE METHOD OF GOBACKDELEGATE
        dele?.nameOfCountry(country: currencyDict.allKeys[indexPath.row]as! String)
        
        //DISMISS VIEWCONTROLLER TO FRONT SCREEN
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
}
