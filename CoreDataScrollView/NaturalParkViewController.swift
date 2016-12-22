//
//  NaturalParkViewController.swift
//  CoreDataScrollView
//
//  Created by iMac on 21/12/2016.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit


class NaturalParkViewController: UIViewController {
    
    var sidebarRight : UIViewController?
    
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    var user : User!
    
    @IBOutlet weak var naturalPlaceCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()                
        navigationItem.hidesBackButton = true
        
        naturalPlaceCollectionView.dataSource   = self
        naturalPlaceCollectionView.delegate     = self        
        
       //http://bdo.se/wp-content/uploads/2014/01/Stockholm1.jpg",
        
       // naturalPlaceCollectionView.isPagingEnabled = true
        //naturalPlaceCollectionView.showsHorizontalScrollIndicator = false
        
        naturalPlaceCollectionView.register(UINib(nibName: "CustomNaturalParkCell", bundle: nil), forCellWithReuseIdentifier: "naturalPlaceCellID")
        
        downloadImages(bookURLs)
        
        _ = CDSToast(message: "Start", target: self)
            
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

extension NaturalParkViewController : UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout   {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "naturalPlaceCellID", for: indexPath) as! CustomNaturalParkCell
        

        print(indexPath.row)
        
        cell.configuration(imageCategory[indexPath.row])
        
        //cell.frame = CGRect(x: 30, y: 5, width: collectionView.bounds.width - 60, height: collectionView.bounds.height - 10)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("resize")
        
        return CGSize(width: collectionView.frame.width - 100 , height: collectionView.frame.height - 66)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func downloadImages (_ imageUrls : [String]) {
        
        var i = 0
        for imageUrl in imageUrls{
            let downloadImage = DispatchQueue(label: "downloadImage\(i)")
            i = i + 1
            let imageView = self.view.viewWithTag(80 + i) as! UIImageView
            startDownload(imageView, imageUrl, downloadImage, i)
            print("call start \(i)")
        }
    }
    
    func startDownload (_ imageView : UIImageView, _ url : String, _ queue : DispatchQueue, _ i : Int) {
        queue.async {
            print("thread \(i) start")
            do{
                let imageURL = URL(string: url)
                let imagedData = try Data(contentsOf: imageURL!)
                imageView.image = UIImage(data: imagedData)
                print("Finis \(i)")
            } catch { }
            print("thread \(i) stop")
        }
    }
    
}
