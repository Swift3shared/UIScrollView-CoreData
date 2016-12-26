//
//  CategoryViewController.swift
//  CoreDataScrollView
//
//  Created by iMac on 21/12/2016.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit


class CategoryViewController: UIViewController {
    
    var sidebarRight : UIViewController?
    
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    var user  : User!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()                
        navigationItem.hidesBackButton = true
        
        collectionView.dataSource   = self
        collectionView.delegate     = self
        setupLayout()
        collectionView.showsHorizontalScrollIndicator = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func userButtonPressed(_ sender: UIBarButtonItem) {
        let sidebarRight = UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier: "sidebarRightID") as! SidebarPopupViewController
        sidebarRight.user       = self.user
        sidebarRight.delegate   = self
        sidebarRight.view.frame = self.view.frame
        UIApplication.shared.delegate?.window!!.addSubview(sidebarRight.view)
        self.addChildViewController(sidebarRight)
    }
    
    fileprivate func setupLayout() {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
}


// collection
extension CategoryViewController : UICollectionViewDataSource, UICollectionViewDelegate{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! CollectionCell
        cell.configuration(imageCategory[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        downloadImages(categoryURLs[indexPath.row])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        _ = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        _ = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
    }
    
    
    func downloadImages (_ imageUrls : [String]) {
        _ = CDSToast(message: "Start download image", target: self)
        clearImage()
        
        let queue = CDSOperationQueue.shared()
        if queue.operationCount > 0 {
            queue.cancelAllOperations()
        }
        
        let operation1 = BlockOperation(block: {
            let img1 = self.getImage(imageUrls[0])
            DispatchQueue.main.async {
                self.imageView1.image = img1
            }
        })
        
        let operation2 = BlockOperation(block: {
            let img2 = self.getImage(imageUrls[1])
            DispatchQueue.main.async{
                self.imageView2.image = img2
            }
        })
        
        let operation3 = BlockOperation(block: {
            let img3 = self.getImage(imageUrls[2])
            DispatchQueue.main.async{
                self.imageView3.image = img3
            }
        })
        let operation4 = BlockOperation(block: {
            let img4 = self.getImage(imageUrls[3])
            DispatchQueue.main.async{
                self.imageView4.image = img4
            }
        })
        
        queue.addOperations([operation1,operation2,operation3, operation4], waitUntilFinished: false)
    
        operation1.completionBlock = {
            self.opComplete(queue.operationCount)
        }
        operation2.completionBlock = {
            self.opComplete(queue.operationCount)
        }
        operation3.completionBlock = {
            self.opComplete(queue.operationCount)
        }
        operation4.completionBlock = {
            self.opComplete(queue.operationCount)
        }
        
    }
    
    func opComplete(_ opCount : Int) {
        if opCount == 0 {
            let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                _ = CDSToast(message: "Download completed.", target: self)
            }
        }
    }
    
    func getImage(_ url : String) -> UIImage {
        do{
            let imageURL = URL(string: url)
            let imagedData = try Data(contentsOf: imageURL!)
            return UIImage(data: imagedData)!
        } catch {
        }
        return UIImage()
    }
    
    func clearImage() {
        imageView1.image = UIImage()
        imageView2.image = UIImage()
        imageView3.image = UIImage()
        imageView4.image = UIImage()
    }
}


