//
//  ViewController.swift
//  d00ex00
//
//  Created by Remy SIBIET on 1/23/18.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HelloText: UILabel!
    @IBAction func clickButton(_ sender: UIButton) {
        print("Hello World !")
        HelloText.text = "Hello World !"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

