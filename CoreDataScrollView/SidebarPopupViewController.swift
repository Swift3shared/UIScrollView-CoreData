//
//  SidebarPopupViewController.swift
//  CoreDataScrollView
//
//  Created by iMac on 21/12/2016.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit

class SidebarPopupViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var user : User!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        showSlideRight()
                
        
        if user != nil {
            usernameLabel.text      = user.userName
            dateOfBirthLabel.text   = user.dateOfBirth
            placeOfBirthLabel.text  = user.placeOfBirth
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.drag)))
    }
//    func gestureRecognizer(gesture : UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer:UIGestureRecognizer) -> Bool {
//        print("asaasas")
//        return true
//    }
    
    func drag(gesture: UIPanGestureRecognizer) {
        print("")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeSlideRight(){
        UIView.animate(withDuration: 0.25, animations:{
            self.view.transform = CGAffineTransform(translationX: 0 , y : 0)
            self.view.alpha = 0.0
        }, completion : {(finished : Bool) in
            if finished
            {
                self.view.removeFromSuperview()
            }
        })
    }
    
    func showSlideRight(){
        self.view.alpha = 0.5
        self.view.transform = CGAffineTransform(translationX: self.view.bounds.width , y: 0)
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(translationX: 0 , y: 0)
            self.view.alpha = 1.0
        })
    }

    @IBAction func editButtonTouchDown(_ sender: Any) {
        performSegue(withIdentifier: "editInformaionID", sender: self.user)
        removeSlideRight()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SignupViewController {
            destination.userToEding = sender as! User
        }
    }
    
}

