//
//  FirstViewController.swift
//  d05_mapKit
//
//  Created by Remy SIBIET on 11/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.lieux.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellView")
        cell?.textLabel?.text = data.lieux[indexPath.row].0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data.index = indexPath[1]
        self.tabBarController?.selectedIndex = 1
    }
}

