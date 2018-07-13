//
//  ViewController.swift
//  d03_photos
//
//  Created by Remy SIBIET on 08/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.imgUrl.count
    }
    
//    alert popup
    func popAlert(url: String) {
        let alert = UIAlertController(title: "Error", message: "Cannot access to " + url, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellView", for: indexPath) as! CollectionViewCell

//        init qualityOfService - multithread -
        let qos = DispatchQoS.userInitiated.qosClass
        let queue = DispatchQueue.global(qos: qos)
        
        cell.activityIndicator.stopAnimating()

//        get image url from list
        let url = URL(string: list.imgUrl[indexPath.row].0)
        
//        async download image
        cell.activityIndicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        queue.async {
            if let d = try? Data(contentsOf: url!) {    
                let data = d
                //            display image with main tread
                DispatchQueue.main.async {
                    list.imgUrl[indexPath.row].2 = UIImage(data: data)
                    cell.img = list.imgUrl[indexPath.row].2
                    cell.activityIndicator.stopAnimating()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            else {
                DispatchQueue.main.async {
                    cell.activityIndicator.stopAnimating()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.popAlert(url: list.imgUrl[indexPath.row].0)
                }
            }
        }
        return cell
    }

//    Send title image to viewControler2
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueNext" {
            if let cell = sender as? UICollectionViewCell,
                let indexPath = self.collectionView.indexPath(for: cell) {
                    let vc = segue.destination as! ViewController2
                    vc.titleimg = list.imgUrl[indexPath.row].1
                    vc.imageView = UIImageView(image: list.imgUrl[indexPath.row].2)
            }
        }
    }
}


















