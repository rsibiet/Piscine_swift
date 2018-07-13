//
//  ViewController.swift
//  botSiriLike
//
//  Created by Remy SIBIET on 16/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var responseLabel: UILabel!

    var bot : RecastAIClient?
    let client = DarkSkyClient(apiKey: "...") // YOUR apiKey
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        
        self.bot = RecastAIClient(token : "...") // Your token
        self.bot = RecastAIClient(token : "...", language: "en") // Your token
        
        client.units = .si
        client.language = .english
    }

    @IBAction func validButton(_ sender: UIButton) {
        //        ex: "what is the weather in London ?"
        if let q = textField.text, textField.text != "" {
            makeRequest(request: q)
        }
        else {
            responseLabel.text = "None question asked..."
        }
    }

//     Make text request to Recast.AI API
    func makeRequest(request: String)
    {
        //Call makeRequest with string parameter to make a text request
        self.bot?.textRequest(request, successHandler: recastRequestDone, failureHandle: errorOccured)
    }
    
    func recastRequestDone(_ response : Response)
    {
        if let location = response.get(entity: "location") {
            getForcastRequest(location: location["raw"] as! String, lat: location["lat"] as! Double, long: location["lng"] as! Double)
        }
        else {
            DispatchQueue.main.async {
                self.responseLabel.text = "Can not get it !"
            }
        }
    }
    
    func errorOccured(error: Error) {
        DispatchQueue.main.async {
            self.responseLabel.text = "An error has occured: \(error)"
        }
    }
    
    func getForcastRequest(location: String, lat: Double, long: Double) {
        self.client.getForecast(latitude: lat, longitude: long) { result in
            switch result {
            case .success(let currentForecast, _):
                DispatchQueue.main.async {
                    self.responseLabel.text = location + " : " + (currentForecast.currently?.summary)! + "\nTemperature : " + String(describing: (currentForecast.currently?.temperature)!) + " °C"
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.responseLabel.text = error as? String
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

