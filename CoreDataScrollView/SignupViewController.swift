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
    
    var oldUsername : String!
    var userToEdit : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate      = self
        passwordTextField.delegate      = self
        verifiedTextField.delegate      = self
        dateOfBirthTextField.delegate   = self
        placeOfBirthTextField.delegate  = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if userToEdit != nil {
            prepareDataToEdit()
        }
    }
    
    func prepareDataToEdit() {
        oldUsername = userToEdit.userName
        usernameTextField.text = oldUsername
        passwordTextField.placeholder  = "Old password"
        verifiedTextField.placeholder  = "New password"
        dateOfBirthTextField.text      = userToEdit.dateOfBirth
        placeOfBirthTextField.text     = userToEdit.placeOfBirth
        signupButton.setTitle("Save", for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        if sender.titleLabel?.text == "Save" && userToEdit != nil {
            
            
//            if passwordTextField.text != "" {
//                Service.login( oldUsername, passwordTextField.text!, success: { user in
//                    
//                }, error: { message in
//                
//                })
//            }else {
                userToEdit.userName        = usernameTextField.text!
                userToEdit.dateOfBirth     = dateOfBirthTextField.text!
                userToEdit.placeOfBirth    = placeOfBirthTextField.text!
            if Service.isNotEmptyTextField(contentOf: usernameTextField, passwordTextField, verifiedTextField, dateOfBirthTextField, placeOfBirthTextField) {
                let newUser = User()
                newUser.userName = usernameTextField.text!
            }
            
            //Service.updateUser(oldUser: userToEdit, newUser: )
            
            
           // }
        }
        else {
            if Service.isNotEmptyTextField(contentOf: usernameTextField, dateOfBirthTextField, placeOfBirthTextField) {
                if Service.isVerified(string: passwordTextField.text!, cmpareTo: verifiedTextField.text!) {
                    
                    let user = User(context: Service.context())
                    user.userName       = usernameTextField.text!
                    user.password       = passwordTextField.text!
                    user.dateOfBirth    = dateOfBirthTextField.text!
                    user.placeOfBirth   = placeOfBirthTextField.text!
                    
                }else {
                    self.present(Service.messageBoxAlert(withTitle: "Error!", forMessage: "Password and verified password in not match.") , animated: true, completion: nil)
                }
            } else {
                self.present(Service.messageBoxAlert(withTitle: "Requred!", forMessage: "All field is required.") , animated: true, completion: nil)
            }
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
