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
        
        toastView                    = UIView(frame: CGRect(x: (view.view.bounds.width / 2) - 100, y: (view.view.bounds.height) - 100, width: 200, height: 50))
        toastView.backgroundColor    = UIColor.black
        toastView.backgroundColor    = UIColor.black.withAlphaComponent(0.4)
        toastView.layer.cornerRadius = 12
        
        messageTextLabel                = UILabel(frame: toastView.frame)
        messageTextLabel.textColor      = UIColor.white
        messageTextLabel.text           = message
        messageTextLabel.textAlignment  = .center
        messageTextLabel.font           = messageTextLabel.font.withSize(12)
        
        view.view.addSubview    (toastView)
        view.view.addSubview    (messageTextLabel)
        CDSAnimation.fadeIn     (toastView)
        CDSAnimation.fadeIn     (messageTextLabel)
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            CDSAnimation.fadeOut(self.messageTextLabel)
            CDSAnimation.fadeOut(self.toastView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
