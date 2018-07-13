//
//  ViewController.swift
//  d00ex02
//
//  Created by Remy SIBIET on 1/23/18.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var screen: UILabel!
    var nb : [Float] = [0, 0, 0]
    var operator1 = ""
    var operator2 = ""
    var pos = 0     // position in operation : 0 nb[0], 1 nb[1], ...
    var inputPos = false // true = digit set, false = operator set
    var in_egual = false // last input is '='
    var divZero = false
    
    @IBOutlet weak var bMore: UIButton!
    @IBOutlet weak var bLess: UIButton!
    @IBOutlet weak var bMul: UIButton!
    @IBOutlet weak var bDiv: UIButton!
    @IBOutlet weak var bEgual: UIButton!
    
    func resetColorButton() {
        bMore.setTitleColor(UIColor.white, for: .normal)
        bLess.setTitleColor(UIColor.white, for: .normal)
        bMul.setTitleColor(UIColor.white, for: .normal)
        bDiv.setTitleColor(UIColor.white, for: .normal)
        bEgual.setTitleColor(UIColor.white, for: .normal)
    }
    
    func printToScreen(nbpos: Int) {
        let fullNb = String(nb[nbpos])
        let fullNbArr = fullNb.split(separator: ".")
        if (fullNbArr[1] == "0") {
            screen.text = String((Int)(nb[nbpos]))
        }
        else {
            screen.text = String(nb[nbpos])
        }
    }
    
    func calcul(val: Float) {
        print("Print ", val, " to screen.")
        nb[pos] *= 10
        nb[pos] += val
        printToScreen(nbpos: pos)
    }
    func resetValues() {
        nb = [0, 0, 0]
        operator1 = ""
        operator2 = ""
        pos = 0
        divZero = false
    }
    func checkState() {
        if (in_egual == true || divZero == true) {
            resetValues()
        }
        inputPos = true
        resetColorButton()
        in_egual = false
    }
    @IBAction func button1(_ sender: UIButton) {
        checkState()
        calcul(val: 1)
    }
    @IBAction func button2(_ sender: UIButton) {
        checkState()
        calcul(val: 2)
    }
    @IBAction func button3(_ sender: UIButton) {
        checkState()
        calcul(val: 3)
    }
    @IBAction func button4(_ sender: UIButton) {
        checkState()
        calcul(val: 4)
    }
    @IBAction func button5(_ sender: UIButton) {
        checkState()
        calcul(val: 5)
    }
    @IBAction func button6(_ sender: UIButton) {
        checkState()
        calcul(val: 6)
    }
    @IBAction func button7(_ sender: UIButton) {
        checkState()
        calcul(val: 7)
    }
    @IBAction func button8(_ sender: UIButton) {
        checkState()
        calcul(val: 8)
    }
    @IBAction func button9(_ sender: UIButton) {
        checkState()
        calcul(val: 9)
    }
    @IBAction func button0(_ sender: UIButton) {
        checkState()
        calcul(val: 0)
    }
    @IBAction func buttonAC(_ sender: UIButton) {
        print("Reset.")
        resetValues()
        printToScreen(nbpos: pos)
        inputPos = false
        in_egual = false
        resetColorButton()
    }
    @IBAction func buttonNEG(_ sender: UIButton) {
        print("result *= -1")
        if (divZero == false) {
            nb[pos] *= -1
            printToScreen(nbpos: pos)
        }
    }
    
    func divByZero() {
        resetValues()
        screen.text = String("Not a number")
        inputPos = false
        in_egual = false
        resetColorButton()
        divZero = true
    }
    
    func preCalc() {
        if (operator1 == "+") {
            nb[0] += nb[1]
        }
        else if (operator1 == "-"){
            nb[0] -= nb[1]
        }
        else if (operator1 == "*"){
            nb[0] *= nb[1]
        }
        else if (operator1 == "/" && nb[1] != 0){
            nb[0] /= nb[1]
        }
        else if (operator1 == "/") {
            divByZero()
        }
        if (in_egual == false) {
            nb[1] = 0
        }
    }
    
    func preCalc2() {
        if (operator2 == "*"){
            nb[1] *= nb[2]
        }
        else if (operator2 == "/" && nb[2] != 0){
            nb[1] /= nb[2]
        }
        else if (operator2 == "/") {
            divByZero()
        }
        if (in_egual == false) {
            nb[2] = 0
        }
    }
    
    func moveVal() {
        if (operator2 != "") {
            operator1 = operator2
            operator2 = ""
            nb[1] = nb[2]
            nb[2] = 0
        }
    }
    
    func calcLessMore(op: String) {
        if (inputPos == true) {
            resetColorButton()
            if (op == "+") {
                bMore.setTitleColor(UIColor.blue, for: .normal)
            }
            else {
                bLess.setTitleColor(UIColor.blue, for: .normal)
            }
            inputPos = false
            if (in_egual == true || operator1 == "") {
                in_egual = false
            }
            else if (operator2 == "") {
                preCalc()
            }
            else {
                preCalc2()
                preCalc()
                moveVal()
            }
            if (divZero == false) {
                printToScreen(nbpos: 0)
                nb[1] = 0
                operator1 = op
                pos = 1
            }
        }
    }

    @IBAction func buttonMore(_ sender: UIButton) {
        print("Touch input More")
        calcLessMore(op: "+")
    }
    @IBAction func buttonLess(_ sender: UIButton) {
        print("Touch input Less")
        calcLessMore(op: "-")
    }
    
    func calcMulDiv(op: String) {
        if (inputPos == true) {
            resetColorButton()
            if (op == "*") {
                bMul.setTitleColor(UIColor.blue, for: .normal)
            }
            else {
                bDiv.setTitleColor(UIColor.blue, for: .normal)
            }
            inputPos = false
            pos = 1
            if (in_egual == true) {
                operator1 = op
                nb[1] = 0
                in_egual = false
            }
            else if (operator2 == "" && operator1 != "-" && operator1 != "+") {
                preCalc()
                if (divZero == false) {
                    operator1 = op
                    printToScreen(nbpos: 0)
                }
            }
            else {
                if (operator2 != "") {
                    preCalc2()
                    if (divZero == true) {
                        return
                    }
                    printToScreen(nbpos: 1)
                }
                pos = 2
                operator2 = op
            }
        }
    }
    
    @IBAction func buttonMul(_ sender: UIButton) {
        print("Touch input Multipl")
        calcMulDiv(op: "*")
    }
    @IBAction func buttonDiv(_ sender: UIButton) {
        print("Touch input Div")
        calcMulDiv(op: "/")
    }
    
    @IBAction func buttonRes(_ sender: UIButton) {
        if (inputPos == false) {
            return
        }
        print("Print result.")
        in_egual = true
        if (operator2 == "" && operator1 != ""){
            preCalc()
        }
        else if (operator2 != "") {
            preCalc2()
            preCalc()
            moveVal()
        }
        pos = 0
        if (divZero == false) {
            printToScreen(nbpos: pos)
        }
        resetColorButton()
        bEgual.setTitleColor(UIColor.blue, for: .normal)
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

