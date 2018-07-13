//
//  tweetTableViewCell.swift
//  d04_requests
//
//  Created by Remy SIBIET on 11/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class tweetTableViewCell: UITableViewCell {

    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var pseudo: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
