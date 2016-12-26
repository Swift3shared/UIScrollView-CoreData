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
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        
        let screenSize = UIScreen.main.bounds
        
        let collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        collectionViewFlowLayout.itemSize = CGSize(width: screenSize.width / 2.0, height: screenSize.height / 2.0)
        
        collectionViewFlowLayout.minimumInteritemSpacing = 0.0
        collectionViewFlowLayout.minimumLineSpacing = 20.0
        
        let screenshotsSectionInset = screenSize.width / 6.0
        
        collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0.0, screenshotsSectionInset, 0.0, screenshotsSectionInset)
            
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
    
    var lastIndex : Int = 0
}


// collection 

extension CategoryViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCategory.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "naturalPlaceCellID", for: indexPath) as! CollectionCell
       cell.configuration(imageCategory[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 120, height: collectionView.frame.height-66)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        downloadImages(categoryURLs[indexPath.row])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        /*
        let cells = collectionView.visibleCells as! [CollectionCell]
        collectionView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
        if cells.count == 2 {
            cells[1].frame = CGRect(x: 40, y: 0, width: collectionView.bounds.width - 80, height: collectionView.bounds.height)
            cells[0].frame = CGRect(x: collectionView.bounds.width - 75, y: 0, width: collectionView.bounds.width - 60, height: collectionView.bounds.height)
        }
        */
         //collectionView.setContentOffset(CGPoint(x: scrollView.contentOffset.x + 25, y: scrollView.contentOffset.y), animated: true)
    }
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
       
        //print("offset : \(xOffset)")
        //print("offset/ factor : \(xOffset / offsetFactor)")
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let screenshotsDistanceBetweenItemsCenter = collectionViewFlowLayout.minimumLineSpacing + collectionViewFlowLayout.itemSize.width
        //let iconsDistanceBetweenItemsCenter = iconsCollectionViewFlowLayout.minimumLineSpacing + iconsCollectionViewFlowLayout.itemSize.width
        let offsetFactor = screenshotsDistanceBetweenItemsCenter / (collectionView.bounds.width / 5)
        print("factor : \(offsetFactor)")
        let xOffset = scrollView.contentOffset.x - scrollView.frame.origin.x
        print("x90 : \(xOffset)")
        print("x90 : \(xOffset / offsetFactor)")
        collectionView.contentOffset.x = xOffset / offsetFactor
    }
    
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        
//        let pageWidth: Float = Float(self.collectionView.frame.width / 3) //480 + 50
//        print(" half = \(pageWidth)") //width + space
//        let currentOffset: Float = Float(scrollView.contentOffset.x)
//        
//        let targetOffset: Float = Float(targetContentOffset.pointee.x)
//        
//        var newTargetOffset: Float = 20
//        
//        print("current off set \(currentOffset)")
//        print("target off set \(targetOffset)")
//        
//        if targetOffset > currentOffset {
//            
//            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
//            print("taget > newtar \(newTargetOffset)")
//            
//        }
//        else {
//            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
//            print("taget eale newtar \(newTargetOffset)")
//        }
//        if newTargetOffset < 0 {
//            print("taget 0 ")
//            newTargetOffset = 100
//        }
////        else if (newTargetOffset > Float(scrollView.contentSize.width)){
////            
////            newTargetOffset = Float(Float(scrollView.contentSize.width))
////            print("taget > newtar \(newTargetOffset)")
////        }
//        
//        //print(currentOffset)
//        //print(targetContentOffset)
//        //newTargetOffset = Float(collectionView.frame.width)
//        //targetContentOffset.pointee.x = CGFloat(newTargetOffset)
//        collectionView.setContentOffset(CGPoint(x: CGFloat(100), y: scrollView.contentOffset.y), animated: true)
//    }
//    
//    func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
//                             withScrollingVelocity velocity: CGPoint) -> CGPoint{
//        return CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y)
//    }
    
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


