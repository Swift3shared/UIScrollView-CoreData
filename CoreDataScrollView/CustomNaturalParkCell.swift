//
//  CustomNaturalParkCell.swift
//  CoreDataScrollView
//
//  Created by sok channy on 12/22/16.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit

class CustomNaturalParkCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.frame = CGRect(x: 20, y: 0, width: 280, height: 200)
    }
    
    func configuration(_ image : UIImage) {
        imageView.image = image
    }
}
