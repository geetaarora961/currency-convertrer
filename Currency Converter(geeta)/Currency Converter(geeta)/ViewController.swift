//
//  ViewController.swift
//  Currency Converter(geeta)
//
//  Created by Manjinder Aulakh on 2019-11-10.
//  Copyright © 2019 Manjinder kaur. All rights reserved.
//

import UIKit


let currencyDict:NSDictionary = ["USA":1.33 , "IND":53.91,"CAD":1 ]
let flagDetectionDict:NSDictionary = ["USA":UIImage(named:"USA")!, "IND":UIImage(named: "india")!,"CAD":UIImage(named: "canada")! ]

class ViewController: UIViewController ,UITableViewDelegate, goBackDelegate{
    
    // OUTLETS OF ELEMENTS FROM STORYBOARD
    @IBOutlet weak var lbl_FromCountry: UILabel!
    @IBOutlet weak var inputamounttextfield: UITextField!
    @IBOutlet weak var fromcountryimageview: UIImageView!
    @IBOutlet weak var tocountryimageview: UIImageView!
    @IBOutlet weak var lbl_ToCountry: UILabel!
    @IBOutlet weak var textfield_Amount:UITextField!
    @IBOutlet weak var lbl_toCountryAmount:UILabel!
    
    
    var countrySelected:String = "CAD" //BY DEFAULT COUNTRY SET TO CANADIANX
    var buttonPressed:Int? //VARIABLE TO STORE WHICH BUTTON IS PRESSED
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //TAP GESTURE ADDDED TO REMOVE KEYBOARD FROM SCREEN ON TAPPING ON SCREEN
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(self.removeKeyboard))
        tapGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        
    }
    //BUTTON ACTION WHEN USER SELECT COUNTRY BUTTON
    @IBAction func action_ChangeCountry(_ sender: UIButton) {
        if sender.tag == 1
        {
            buttonPressed = 1
        }
        else
        {
            buttonPressed = 2
        }
        //PERFORM SEGUE METRHOD
        self.performSegue(withIdentifier: "currencyToList", sender: self)
    }
    //DELEGATE METHOD OF GOBACKDELEGATE AND IN THIS METHOD WE RECEIVE DATA WHEN WE SELECT COUNTRY
    func nameOfCountry(country: String) {
        countrySelected = country
        if buttonPressed == 1
        {
            //SHOWING UP FROM COUNTRY AND FLAG
            lbl_FromCountry.text = country
            fromcountryimageview.image = flagDetectionDict.value(forKey: country) as! UIImage
        }
        else
        {
            //SHOWING UP TO COUNTRY AND FLAG
            lbl_ToCountry.text = country
            tocountryimageview.image = flagDetectionDict.value(forKey: country) as! UIImage
        }
        print("am back")
    }
    //TAP GESTURE METHOD TO REMOVE KEYBOARD FROM SCREEN
    @objc   func removeKeyboard()
    {
        textfield_Amount.resignFirstResponder()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //SEGUE FROM VIEWCOTROLLER TO CURRENCYCHANGETABLEVIEWCONTROLLER
        if segue.identifier == "currencyToList"
        {
            
            
            let vc = segue.destination as! currencychangeTableViewController
            //CONNECTING THE DELEGATE OF PROTOCOL GOBACKDELEGATE IN  CURRENT VIEWCONTROLLER
            vc.dele = self
        }
    }
    //CONVERSION
    @IBAction func action_ConvertCurrency(_ sender: UIButton) {
        
        if textfield_Amount.text != ""
        {
            
            
            let fromCountryAmount:Double = NSString(string:(textfield_Amount.text!)).doubleValue
            if lbl_FromCountry.text == "CAD" // IF CONVERSION IS FROM CANADIAN DOLLARS TO OTHER COUNTRY
            {
                switch lbl_ToCountry.text{
                case "USA":
                    
                    
                    lbl_toCountryAmount.text = "\(fromCountryAmount/1.33)"
                    
                    print("convert in us dollars")
                case "IND":
                    lbl_toCountryAmount.text = "\(fromCountryAmount*53.91)"
                    print("convert in indian rs")
                default:
                    lbl_toCountryAmount.text = textfield_Amount.text
                    break
                }
            }
            else if lbl_FromCountry.text == "USA" // IF CONVERSION US FROM US DOLLARS TO OTHER COUNTRY
            {
                switch lbl_ToCountry.text{
                case "CAD":
                    lbl_toCountryAmount.text = "\(fromCountryAmount*1.33)"
                case "IND":
                    lbl_toCountryAmount.text = "\(fromCountryAmount*(1.33*53.91))"
                default:
                    lbl_toCountryAmount.text = textfield_Amount.text
                    break
                }
            }
            else // IF CONVERSION IS FROM INDIA TO OTHER COUNTRY
            {
                switch lbl_ToCountry.text{
                case "USA":
                    lbl_toCountryAmount.text = "\(fromCountryAmount*1.33*53.91)"
                    print("convert in us dollars")
                case "CAD":
                    lbl_toCountryAmount.text = "\(fromCountryAmount*53.91)"
                    print("convert in canadian dollars")
                default:
                    lbl_toCountryAmount.text = textfield_Amount.text
                    break
                }
            }
        }
        else
        {
            // ALERT IS BEING SHOWN WHEN NO AMOUNT IS ADDED
            let alert = UIAlertController(title: "Currnecy Converter", message: "Please enter the amount for conversion.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
}

extension ViewController:UITextFieldDelegate
{
    //TEXTDELEGATE METHOD TO NOT LET USER ENTER MORE THAN 8 DIGITS
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == ""
        {
            lbl_toCountryAmount.text = ""
        }
        
        if textfield_Amount.text!.count > 7
        {
            if string == ""
            {
                return true
            }else
            {
                return false
            }
            
        }
        else
        {
            return true
        }
        
    }
    
}



