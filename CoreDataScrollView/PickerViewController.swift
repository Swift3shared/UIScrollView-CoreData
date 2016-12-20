//
//  PickerViewController.swift
//  CoreDataScrollView
//
//  Created by sok channy on 12/20/16.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        showAnimate()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
        
    @IBAction func cancelButtonTouchUp(_ sender: Any) {
        self.removePopup()
    }
    
    @IBAction func okButtonTouchUp(_ sender: Any) {
    
    }
    
    func removePopup(){
        UIView.animate(withDuration: 0.25, animations:{
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
                
        }, completion : {(finished : Bool) in
            if finished
            {
                self.view.removeFromSuperview()
            }
        })
    }
}
