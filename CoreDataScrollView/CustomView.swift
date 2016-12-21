//
//  CustomView.swift
//  CoreDataScrollView
//
//  Created by iMac on 20/12/2016.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit

@IBDesignable
class CDSUIButton : UIButton{
    @IBInspectable
    var borderWith : CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWith
        }
    }
    @IBInspectable
    var borderColor : UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

@IBDesignable
class CDSUITextField : UITextField{
    @IBInspectable
    var borderRaduis : CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = borderRaduis
        }
    }
    
    @IBInspectable
    var borderColor : UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWith : CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWith
        }
    }
}

@IBDesignable
class CDSUIDatePicker : UIDatePicker {
  
}
