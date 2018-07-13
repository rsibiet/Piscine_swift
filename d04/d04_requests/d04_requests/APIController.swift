//
//  APIController.swift
//  d04_requests
//
//  Created by Remy SIBIET on 10/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import Foundation

protocol APITwitterDelegate : class {
    func takeTweet(Tweet: [Tweet])
    func errorCase(error: NSError)
}

// Encode percent
func percentEncode(str: String) -> String {
    return str.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
}

class APIController {
    
    var tweets: [Tweet] = []
    weak var delegate : APITwitterDelegate? // qui sera plus tard notre ViewController
    let token : String //qui sera le token de connection à Twitter
    
    init (delegate : APITwitterDelegate?, token : String) {
        self.delegate = delegate
        self.token = token
    }
    
    func requestTwitter(toSearch: String) {
        let url = NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?q=" + percentEncode(str: toSearch) + "&result_type=recent&lang=fr&count=100")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("bearer " + token, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                if let APIdelegate: APITwitterDelegate = self.delegate {
                    APIdelegate.errorCase(error: err as NSError)
                }
                print(err)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary,
                        let arrayStatuses = dic["statuses"] as? [[String:AnyObject]] {
                        print("Data items count: \(arrayStatuses.count)")
                        self.tweets = []
                        for status in arrayStatuses {
                            let text = status["text"] as! String
                            let user = status["user"]?["name"]  as! String
                            if let date = status["created_at"] as? String {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                                if let date = dateFormatter.date(from: date) {
                                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                                    let newDate = dateFormatter.string(from: date)
                                    self.tweets.append(Tweet(name: user, text: text, date: newDate))
                                }
                            }
                        }
                    }
                    if let APIdelegate: APITwitterDelegate = self.delegate {
                        APIdelegate.takeTweet(Tweet: self.tweets)
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
}
