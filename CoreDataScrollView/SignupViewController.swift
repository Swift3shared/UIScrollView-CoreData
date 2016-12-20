//
//  SignupViewController.swift
//  CoreDataScrollView
//
//  Created by sok channy on 12/20/16.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dateOfBirthTouchDown(_ sender: Any) {
    }
    
    
    @IBAction func placeOfBirthTouchDown(_ sender: Any) {
        let popUpOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ErrorPopup") as! PopupViewController
        self.addChildViewController(popUpOverVc)
        popUpOverVc.view.frame = self.view.frame
        self.view.addSubview(popUpOverVc.view)
        popUpOverVc.labelMessage.text = Message
        popUpOverVc.didMove(toParentViewController: self)
        
    }
    
}
