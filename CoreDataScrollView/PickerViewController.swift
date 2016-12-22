//
//  PickerViewController.swift
//  CoreDataScrollView
//
//  Created by sok channy on 12/20/16.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    
    var delegate : UIViewController!
    
    var data : [String]?
    var isDatePicker = false, placeOfBirth : String? = nil
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        showAnimate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isDatePicker {
            pickerView.isHidden = true
            datePickerView.isHidden = false
        } else {
            datePickerView.isHidden = true
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.isHidden = false
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func cancelButtonTouchUp(_ sender: Any) {
         self.removePopup()
    }

    @IBAction func okButtonTouchUp(_ sender: Any) {
        if let delegate = self.delegate as? SignupViewController {
            if isDatePicker {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM/dd/yyyy"
                let dateString = dateFormatter.string(from: datePickerView.date)
                delegate.dateOfBirthTextField.text = dateString
            }else {
                    delegate.placeOfBirthTextField.text = placeOfBirth ?? data?[0]
            }
        }else {
            let delegate = self.delegate as? SidebarPopupViewController
            if isDatePicker {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM/dd/yyyy"
                let dateString = dateFormatter.string(from: datePickerView.date)
                delegate?.dateOfBirthTextField.text = dateString
            }else {
                delegate?.placeOfBirthTextField.text = placeOfBirth ?? data?[0]
            }
        }
        removePopup()
    }
    
    func removePopup(){
        CDSAnimation.fadeOut(self.view)
    }
    
    
    func showAnimate(){
        CDSAnimation.fadeIn(self.view)
    }
}

extension PickerViewController : UIPickerViewDelegate, UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (data?.count)!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (data?[row])!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.placeOfBirth = data?[row]
    }
}
