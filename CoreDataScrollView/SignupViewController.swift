//
//  SignupViewController.swift
//  CoreDataScrollView
//
//  Created by sok channy on 12/20/16.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit
import CoreData

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: CDSUITextField!
    
    @IBOutlet weak var passwordTextField: CDSUITextField!
    
    @IBOutlet weak var verifiedTextField: CDSUITextField!
    
    @IBOutlet weak var dateOfBirthTextField: CDSUITextField!
    
    @IBOutlet weak var placeOfBirthTextField: CDSUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func signinButtonTouchUpInside(_ sender: Any) {
        if Service.isNotEmptyTextField(contentOf: usernameTextField, dateOfBirthTextField, placeOfBirthTextField) {
            if Service.isVerified(string: passwordTextField.text!, cmpareTo: verifiedTextField.text!) {
                
                let user = User(context: appContext)
                user.userName       = usernameTextField.text!
                user.password       = passwordTextField.text!
                user.placeOfBirth   = dateOfBirthTextField.text!
                user.placeOfBirth   = placeOfBirthTextField.text!
                
//                appDelegate.saveContext()
                
            }else {
                self.present(Service.messageBoxAlert(withTitle: "Error!", forMessage: "Password and verified password in not match.") , animated: true, completion: nil)
            }
        } else {
            self.present(Service.messageBoxAlert(withTitle: "Requred!", forMessage: "All field is required.") , animated: true, completion: nil)
        }
    }

    
    @IBAction func dateOfBirthTouchDown(_ sender: Any) {
        let datePickerePopup = UIStoryboard(name: "Popup", bundle: nil).instantiateViewController(withIdentifier: "pickerViewControllerID") as! PickerViewController
        datePickerePopup.isDatePicker = true
        datePickerePopup.delegate = self
        self.addChildViewController(datePickerePopup)
        datePickerePopup.view.frame = self.view.frame
        self.view.addSubview(datePickerePopup.view)
        datePickerePopup.didMove(toParentViewController: self)
        
    }
    
    
    @IBAction func placeOfBirthTouchDown(_ sender: Any) {
        let provincesPickerePopup = UIStoryboard(name: "Popup", bundle: nil).instantiateViewController(withIdentifier: "pickerViewControllerID") as! PickerViewController
        provincesPickerePopup.delegate = self
        provincesPickerePopup.data = provinces
        self.addChildViewController(provincesPickerePopup)
        provincesPickerePopup.view.frame = self.view.frame
        self.view.addSubview(provincesPickerePopup.view)
        provincesPickerePopup.didMove(toParentViewController: self)
    }
    
}
