//
//  SignupViewController.swift
//  CoreDataScrollView
//
//  Created by sok channy on 12/20/16.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit
import CoreData

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var verifiedTextField: UITextField!
    
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    @IBOutlet weak var placeOfBirthTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate      = self
        passwordTextField.delegate      = self
        verifiedTextField.delegate      = self
        dateOfBirthTextField.delegate   = self
        placeOfBirthTextField.delegate  = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        usernameTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
            return false
        }else if textField == passwordTextField {
            verifiedTextField.becomeFirstResponder()
            return false
        }
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signinButtonTouchUpInside(_ sender: UIButton) {
        if Service.isNotEmptyTextField(contentOf: usernameTextField, dateOfBirthTextField, placeOfBirthTextField) {
            if Service.isVerified(string: passwordTextField.text!, cmpareTo: verifiedTextField.text!) {
                
                let user = User(context: Service.context())
                user.userName       = (usernameTextField.text!).trimmingCharacters(in: .whitespacesAndNewlines)
                user.password       = (passwordTextField.text!).trimmingCharacters(in: .whitespacesAndNewlines)
                user.dateOfBirth    = dateOfBirthTextField.text!
                user.placeOfBirth   = placeOfBirthTextField.text!
                Service.delegate().saveContext()
                
                _ = navigationController?.popToRootViewController(animated: true)
                
            }else {
                self.present(Service.messageBoxAlert(withTitle: "Error!", forMessage: "Password and verified password in not match.") , animated: true, completion: nil)
            }
        } else {
            self.present(Service.messageBoxAlert(withTitle: "Requred!", forMessage: "All field is required.") , animated: true, completion: nil)
        }
    }

    
    @IBAction func dateOfBirthTouchDown(_ sender: Any) {
        datePickerPopup()
    }
    
    
    @IBAction func placeOfBirthTouchDown(_ sender: Any) {
        pickerViewPopup()
    }
    
    func datePickerPopup() {
        let datePickerePopup = UIStoryboard(name: "Popup", bundle: nil).instantiateViewController(withIdentifier: "pickerViewControllerID") as! PickerViewController
        datePickerePopup.isDatePicker = true
        datePickerePopup.delegate = self
        datePickerePopup.view.frame = self.view.frame
        UIApplication.shared.delegate?.window!!.addSubview(datePickerePopup.view)
        self.addChildViewController(datePickerePopup)
    }
    
    func pickerViewPopup() {
        let provincesPickerePopup = UIStoryboard(name: "Popup", bundle: nil).instantiateViewController(withIdentifier: "pickerViewControllerID") as! PickerViewController
        provincesPickerePopup.delegate = self
        provincesPickerePopup.data = provinces
        provincesPickerePopup.view.frame = self.view.frame
        UIApplication.shared.delegate?.window!!.addSubview(provincesPickerePopup.view)
        self.addChildViewController(provincesPickerePopup)
    }
    
}
