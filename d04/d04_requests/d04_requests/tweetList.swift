//
//  tweetList.swift
//  d04_requests
//
//  Created by Remy SIBIET on 09/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import Foundation

struct Tweet : CustomStringConvertible {
    let name : String, text : String, date : String

    var description: String {
        return "(\(name), \(text), \(date)"
    }
}
