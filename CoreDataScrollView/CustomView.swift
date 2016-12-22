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
    var borderRaduis : CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = borderRaduis
        }
    }
    
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
class CDSUINavigationController : UINavigationController {
    @IBInspectable
    var itemColor : UIColor = UIColor.clear {
        didSet {
            self.navigationItem.titleView?.backgroundColor = itemColor
        }
    }
}

class CDSAnimation {
    class func slideRightToLeftInt (_ view : UIView) {
        view.alpha = 0.5
        view.transform = CGAffineTransform(translationX: view.bounds.width , y: 0)
        UIView.animate(withDuration: 0.25, animations: {
            view.transform = CGAffineTransform(translationX: 0 , y: 0)
            view.alpha = 1.0
        })
    }
    
    class func slideLeftToRightOut (_ view : UIView) {
        UIView.animate(withDuration: 0.25, animations:{
            view.transform = CGAffineTransform(translationX: 0 , y : 0)
            view.alpha = 0.0
        }, completion : {(finished : Bool) in
            if finished
            {
                view.removeFromSuperview()
            }
        })
    }
    
    class func fadeIn(_ view : UIView) {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            view.alpha = 1.0
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    class func fadeOut(_ view : UIView){
        
    }
    
    class func shake(_ view : UIView) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)        
        animation.repeatCount = 6
        animation.duration = (0.5) / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = -5
        view.layer.add(animation, forKey: "shake")
    }
    
}

