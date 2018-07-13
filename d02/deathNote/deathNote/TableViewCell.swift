//
//  TableViewCell.swift
//  deathNote
//
//  Created by Remy SIBIET on 02/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.black
        
        self.backView.layer.borderWidth = 6
        self.backView.layer.cornerRadius = 12
        self.backView.layer.masksToBounds = true
       
        // Initialization code
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var describe: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var death : (String, String, String)? {
        didSet {
            if let d = death {
                name?.text = d.0
                describe?.text = d.1
                date?.text = d.2
            }
        }
    }
}


























