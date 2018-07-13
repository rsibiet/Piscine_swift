//
//  view.swift
//  motionCube
//
//  Created by Remy SIBIET on 13/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class myView: UIView {
    
    let size : CGFloat = 100
    var isCircle = true
    init(point: CGPoint, maxwidth: CGFloat, maxheight: CGFloat) {
        var x : CGFloat
        var y : CGFloat
        if (UIScreen.main.bounds.width < point.x + size/2) {
            x = UIScreen.main.bounds.width - size
        }
        else if (point.x - size < 0) { x = 0 }
        else { x = point.x - size/2 }
        if (UIScreen.main.bounds.height < point.y + size/2) {
            y = UIScreen.main.bounds.height - size
        }
        else if (point.y - size < 20) { y = 20 }
        else { y = point.y - size/2 }
        
        let r = arc4random_uniform(_: 2)
        super.init(frame: CGRect(x: x, y: y, width: size, height: size))
        switch r {
        case 0:
            isCircle = false
        default:
            self.layer.cornerRadius = size/2
        }

//         get random color
        self.backgroundColor = getRandomColor()
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        if isCircle == true {
            return .ellipse
        }
        return .rectangle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getRandomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }

}
