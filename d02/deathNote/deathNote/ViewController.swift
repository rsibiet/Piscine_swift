//
//  ViewController.swift
//  deathNote
//
//  Created by Remy SIBIET on 02/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.backgroundColor = UIColor.black
        let cell = tableView.dequeueReusableCell(withIdentifier: "deathNoteCell") as! TableViewCell
        cell.death = Data.list[indexPath.row]
        
        return cell
    }

    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        print("ICI")
    }
    
//    var nameTab: String?
    @IBAction func unWindSegueDoneButton(segue: UIStoryboardSegue) {
        guard let ViewController2 = segue.source as? ViewController2,
            let name = ViewController2.name,
            let descript = ViewController2.descript,
            let dateVal = ViewController2.dateVal else {
                return
        }
        print("\nReceived instructions:\n     Name who will die: ", name)
        print("     Date of death: ", dateVal)
        print("     Description of death: ", descript)
        
        // add the new death to the list array
        if name != "" {
            Data.list.append((name, descript, dateVal))
            // update the tableView
            let indexPath = IndexPath(row: Data.list.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}

