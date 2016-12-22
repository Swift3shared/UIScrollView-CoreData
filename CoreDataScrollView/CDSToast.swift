//
//  CDSToast.swift
//  CoreDataScrollView
//
//  Created by sok channy on 12/22/16.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit

class CDSToast: UIViewController {
    
    var toastView : UIView!
    var messageTextLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    init(message : String, target view : UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        toastView = UIView(frame: CGRect(x: (view.view.bounds.width / 2) - 100, y: (view.view.bounds.height) - 100, width: 200, height: 50))
        messageTextLabel 
        
        toastView.backgroundColor = UIColor.black
        
        toastView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        toastView.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.toastView.alpha = 0.6
            self.toastView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
        view.view.addSubview(toastView)
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            //self.toastView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.toastView.alpha = 0.6
            self.toastView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: 0.25, animations: {
                self.toastView.alpha = 0.0
                self.toastView.removeFromSuperview()
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
