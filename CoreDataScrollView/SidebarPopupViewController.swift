//
//  SidebarPopupViewController.swift
//  CoreDataScrollView
//
//  Created by iMac on 21/12/2016.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit

class SidebarPopupViewController: UIViewController {
    
    var user : User!
    var delegate : UIViewController!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: CDSUITextField!
    @IBOutlet weak var dateOfBirthTextField: CDSUITextField!
    @IBOutlet weak var placeOfBirthTextField: CDSUITextField!    
    @IBOutlet weak var verifiedPasswordTextField: CDSUITextField!
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var editIfomationView: UIView!
    @IBOutlet weak var sidebarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        showSlideRight()
        
        if user != nil {
            usernameLabel.text      = user.userName
            dateOfBirthLabel.text   = user.dateOfBirth
            placeOfBirthLabel.text  = user.placeOfBirth
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func removeSlideRight(){
        CDSAnimation.slideLeftToRightOut(self.view)
    }
    
    func showSlideRight(){
        CDSAnimation.slideRightToLeftInt (self.view)
    }
    
    func prepareForEdit() {
        usernameTextField.text      = user.userName
        dateOfBirthTextField.text   = user.dateOfBirth
        placeOfBirthTextField.text  = user.placeOfBirth
    }
}

// action
extension SidebarPopupViewController {
    
    @IBAction func editButtonTouchDown(_ sender: Any) {
        editIfomationView.frame = view.frame
        sidebarView.isHidden    = true        
        CDSAnimation.fadeIn(editIfomationView)
        view.addSubview(editIfomationView)
        prepareForEdit()
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        removeSlideRight()
        _ = delegate.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func dissmisEditInforPressed(_ sender: Any) {
        removeSlideRight()
    }
    
    @IBAction func saveEditInforPressed(_ sender: Any) {
        if user.password == verifiedPasswordTextField.text! {
            if Service.isNotEmptyTextField(contentOf: usernameTextField, dateOfBirthTextField, placeOfBirthTextField) {
                
                let data : [String:String] = ["userName" : usernameTextField.text! , "dateOfBirth": dateOfBirthTextField.text!, "placeOfBirth": placeOfBirthTextField.text!]
                Service.updateUser(oldUser: user, newUser: data)                
                removeSlideRight()
            }
        }else{
            CDSAnimation.shake(verifiedPasswordTextField)           
        }
        
    }
}

