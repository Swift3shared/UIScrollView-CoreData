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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dateOfBirthTouchDown(_ sender: Any) {
    }
    
    
    @IBAction func placeOfBirthTouchDown(_ sender: Any) {
        let popUpOverVc = UIStoryboard(name: "Popup", bundle: nil).instantiateViewController(withIdentifier: "pickerViewControllerID") as! PickerViewController
        self.addChildViewController(popUpOverVc)
        popUpOverVc.view.frame = self.view.frame
        self.view.addSubview(popUpOverVc.view)
        popUpOverVc.didMove(toParentViewController: self)        
    }
    
}
