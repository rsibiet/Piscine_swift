//
//  ViewController.swift
//  d04_requests
//
//  Created by Remy SIBIET on 09/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var apiController : APIController?
    var token : String?
    let CUSTOMER_KEY = "..." // YOUR CUSTOMER_KEY
    let CONSUMER_SECRET = "..." // YOUR CONSUMER_SECRET
    var tweets: [Tweet] = []
    
    @IBOutlet weak var searchTweet: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        searchTweet.resignFirstResponder()
        self.apiController?.requestTwitter(toSearch: searchTweet.text!)
        return true
    }
    
    @IBOutlet weak var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as? tweetTableViewCell
        cell?.descript.text = tweets[indexPath.row].text
        cell?.pseudo.text = tweets[indexPath.row].name
        cell?.date.text = tweets[indexPath.row].date
        return cell!
    }
    
    //traiter les Tweet reçus
    func takeTweet(Tweet: [Tweet]) {
        self.tweets = Tweet
        for t in tweets {
            print(t)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    //en cas d’erreur
    func errorCase(error: NSError) {
        print(error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
        searchTweet.delegate = self
    }
    
    func getToken() {
        let BEARER = ((CUSTOMER_KEY + ":" + CONSUMER_SECRET).data(using: String.Encoding.utf8, allowLossyConversion: false))!.base64EncodedString()
        let url = NSURL(string: "https://api.twitter.com/oauth2/token")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        self.token = (dic["access_token"] as? String)!
                        self.apiController = APIController(delegate: self, token: self.token!)
                        self.apiController?.requestTwitter(toSearch: "ecole 42")
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
