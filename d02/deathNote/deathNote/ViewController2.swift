//
//  ViewController2.swift
//  deathNote
//
//  Created by Remy SIBIET on 02/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setName.delegate = self
        setDescription.delegate = self
        
//       Custom TextView setDescription
        setDescription.layer.borderWidth = 1
        setDescription.layer.cornerRadius = 10
        
//       Custom TextField setName
        setName.layer.borderWidth = 1
        
//        Set minimum valid date
        setDate.minimumDate = Date()
        
//**      autoscroll when keyboard Show then Hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//**      autoscroll when keyboard Show then Hide
    let scrollView = UIScrollView()
    @objc func keyboardWillShow(noti: NSNotification) {
        if let keyboardSize = (noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
        }
    }
    @objc func keyboardWillHide(noti: NSNotification) {
        scrollView.contentInset.bottom = 0
    }

    var name: String?
    var descript: String?
    var strDate: String?
    var dateVal: String?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backSegueDone",
            let nameSetted = setName.text {
                name = nameSetted
        }
        if segue.identifier == "backSegueDone",
            let descriptSetted = setDescription.text {
                descript = descriptSetted
        }
        if segue.identifier == "backSegueDone" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            strDate = dateFormatter.string(from: setDate.date)
            dateVal = strDate
        }
    }
    
    //       Action when push backButton "Death Note"
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "backSegue", sender: self)
    }
    
    @IBOutlet weak var setName: UITextField!
    @IBOutlet weak var setDescription: UITextView!
    @IBOutlet weak var setDate: UIDatePicker!
    
    //       Define max size TextFiel setName
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.utf8CString.count + string.utf8CString.count - range.length
        return newLength <= 12
    }
    
    //       Define max size TextView setDescription
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 400
    }
    
    //       Action when push doneButton
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "backSegueDone", sender: self)
    }
}
