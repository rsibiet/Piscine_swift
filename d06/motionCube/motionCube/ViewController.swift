//
//  ViewController.swift
//  motionCube
//
//  Created by Remy SIBIET on 13/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var animator:UIDynamicAnimator? = nil;
    let gravity = UIGravityBehavior()
    let collision = UICollisionBehavior()
    var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gravity.magnitude = 2
        animator = UIDynamicAnimator(referenceView: self.view)
        animator?.addBehavior(gravity)
        collision.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision)
        
//        core Motion
        let motionManager = CMMotionManager()
        
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            let queue = OperationQueue.main
            motionManager.startDeviceMotionUpdates(to: queue, withHandler: gravityUpdated as! CMDeviceMotionHandler)
        }
    }
    
    func gravityUpdated(motion: CMDeviceMotion!, error: NSError!) {
        if (error != nil) {
            NSLog("\(error)")
        }
        
        let grav : CMAcceleration = motion.gravity;
        
        var x = CGFloat(grav.x);
        var y = CGFloat(grav.y);
        
        // Have to correct for orientation.
        let orientation = UIApplication.shared.statusBarOrientation;
        
        if orientation == UIInterfaceOrientation.landscapeLeft {
            let t = x
            x = 0 - y
            y = t
        } else if orientation == UIInterfaceOrientation.landscapeRight {
            let t = x
            x = y
            y = 0 - t
        } else if orientation == UIInterfaceOrientation.portraitUpsideDown {
            x *= -1
            y *= -1
        }
        
        let v = CGVector(dx: x, dy: 0 - y)
        gravity.gravityDirection = v
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        let shape = myView(point: sender.location(in: view), maxwidth: self.view.bounds.width, maxheight: self.view.bounds.height)
        self.view.addSubview(shape)
        gravity.addItem(shape)
        collision.addItem(shape)
//      Elasticity & density & friction
        let bounce = UIDynamicItemBehavior(items: [shape])
        bounce.elasticity = 0.8
        bounce.density = 2
        bounce.friction = 0.5
        animator?.addBehavior(bounce)
        
//      UIPanGestureRecognizer pour les déplacer
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(gesture:)))
        shape.addGestureRecognizer(gesture)
        
//      UIPinchGestureRecognizer pour les agrandir et les réduire.
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(recognizer:)))
        shape.addGestureRecognizer(pinch)
        
//      UIRotationGesture pour les tourner.
        let rot = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(recognizer:)))
        shape.addGestureRecognizer(rot)
    }
    
    @objc func handleRotation(recognizer: UIRotationGestureRecognizer) {
        if recognizer.state == .began {
            self.gravity.removeItem(recognizer.view!)
            self.collision.removeItem(recognizer.view!)
        }
       else if recognizer.state == .changed {
            recognizer.view?.transform = (recognizer.view?.transform.rotated(by: recognizer.rotation))!
            animator?.updateItem(usingCurrentState: recognizer.view!)
            recognizer.rotation = 0
        }
        else if recognizer.state == .ended {
            self.gravity.addItem(recognizer.view!)
            self.collision.addItem(recognizer.view!)
        }

    }
    
    @objc func handlePinch(recognizer: UIPinchGestureRecognizer) { guard recognizer.view != nil else { return }
        if recognizer.state == .began {
            self.gravity.removeItem(recognizer.view!)
            self.collision.removeItem(recognizer.view!)
        }
        else if recognizer.state == .changed {
            recognizer.view?.layer.bounds.size.height *= recognizer.scale
            recognizer.view?.layer.bounds.size.width *= recognizer.scale
            if let t = recognizer.view! as? myView {
                if (t.isCircle) {
                    recognizer.view!.layer.cornerRadius *= recognizer.scale
                }
            }
            if UIScreen.main.bounds.width - 60 < (recognizer.view?.layer.bounds.size.width)! {
                recognizer.view?.layer.bounds.size.height = UIScreen.main.bounds.width - 60
                recognizer.view?.layer.bounds.size.width = UIScreen.main.bounds.width - 60
                if let t = recognizer.view! as? myView {
                    if (t.isCircle) {
                        recognizer.view!.layer.cornerRadius = (UIScreen.main.bounds.width - 60) / 2
                    }
                }
            }
            recognizer.scale = 1.0
        }
        else if recognizer.state == .ended {
            self.gravity.addItem(recognizer.view!)
            self.collision.addItem(recognizer.view!)
        }
    }
    
    @objc func panGesture(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            self.gravity.removeItem(gesture.view!)
        }
        else if gesture.state == .changed {
            gesture.view?.center = gesture.location(in: gesture.view?.superview)
            animator?.updateItem(usingCurrentState: gesture.view!)
        }
        else if gesture.state == .ended {
            self.gravity.addItem(gesture.view!)
        }
    }
    
    //    uidynamicanimator swift example
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

