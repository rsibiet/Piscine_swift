//
//  ViewController2.swift
//  d03_photos
//
//  Created by Remy SIBIET on 09/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIScrollViewDelegate {
    let screenWidth : CGFloat = UIScreen.main.bounds.width > UIScreen.main.bounds.height ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
    let screenHeight : CGFloat = UIScreen.main.bounds.height > UIScreen.main.bounds.width ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
    var imageWidth : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        set title to navBar
        self.title = titleimg
        
//        set scroolView
        imageWidth = (imageView?.frame.size.width)!
        scroolView.addSubview(imageView!)
        scroolView.contentSize = (imageView?.frame.size)!
        scroolView.maximumZoomScale = 2
        minimimZoom()
    }
    
//    Set minimum zoom
    func minimimZoom() {
        if (UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight) {
            scroolView.minimumZoomScale = screenHeight / imageWidth
        }
        else {
            scroolView.minimumZoomScale = screenWidth / imageWidth
        }
    }
    
//    Detection rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        minimimZoom()
    }

    var titleimg : String = "No title"
    var imageView : UIImageView?
    @IBOutlet weak var scroolView: UIScrollView!
    
//        Active scrolling
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
