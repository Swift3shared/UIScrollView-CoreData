//
//  LoginViewController.swift
//  CoreDataScrollView
//
//  Created by iMac on 20/12/2016.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: CDSUITextField!
    
    @IBOutlet weak var passwordTextField: CDSUITextField!
    
    @IBOutlet weak var loginButton: CDSUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userNameTextField.becomeFirstResponder()
    }

    @IBAction func loginButtonTouchDown(_ sender: Any) {
        if Service.isNotEmptyTextField(contentOf: userNameTextField, passwordTextField) {
            Service.login(userNameTextField.text!, passwordTextField.text!, success: { user in
                performSegue(withIdentifier: "naturalParkID", sender: user)
            }, error: { message in
                self.present(Service.messageBoxAlert(withTitle: "Error", forMessage: message), animated: true, completion: nil)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CategoryViewController {
            destination.user = sender as! User
        }
    }
}
