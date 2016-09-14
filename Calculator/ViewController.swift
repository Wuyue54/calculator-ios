//
//  ViewController.swift
//  Calculator
//
//  Created by Yanpu Wu on 9/10/16.
//  Copyright © 2016 Yanpu Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lastNum = 0.0
    var currentNum = 0.0
    var option: String = ""
    
    var initialState = 0
    var currentState = 0
    var btnArray = []
    
    @IBOutlet weak var numberDisplayLabel: UILabel!
    
    @IBOutlet weak var operatorDisplayLabel: UILabel!
    //operator btns
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var PosNegBtn: UIButton!
    @IBOutlet weak var percentBtn: UIButton!
    @IBOutlet weak var divBtn: UIButton!
    @IBOutlet weak var mulBtn: UIButton!
    @IBOutlet weak var minBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var eqBtn: UIButton!
    
    //number btns
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btnDot: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnArray = [divBtn, mulBtn, minBtn, plusBtn]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numPadPressedAction(sender: UIButton) {
        checkState(currentState, btn: 0)
        let result = numberDisplayLabel.text!
        switch sender{
        case btn0:
            if (Double(result) == 0){
                return
            }else{
                numberDisplayLabel.text! += "0"
            }
        case btnDot:
            if(result.containsString(".")||result.containsString("e")){
                return
            }else{
                numberDisplayLabel.text! += "."
            }
        default:
            if(result == "0"){
                numberDisplayLabel.text! = ""
            }
            numberDisplayLabel.text! += sender.titleLabel!.text!
        }
        
        currentNum = Double(numberDisplayLabel.text!)!
//        print("currentNum", currentNum)
    }

    @IBAction func operatorPressedAction(sender: UIButton) {
        var result = currentNum
        switch sender {
        case clearBtn:
            operatorDisplayLabel.text! = ""
            numberDisplayLabel.text! = "0"
            currentState = 0
            lastNum = 0
            currentNum = 0
            option = ""
        case PosNegBtn:
            if(result>0){
                numberDisplayLabel.text! = "-"+String(result)
                currentNum = Double(numberDisplayLabel.text!)!
            }else{
                result = -result
                numberDisplayLabel.text! = String(result)
                currentNum = Double(numberDisplayLabel.text!)!
            }
        case percentBtn:
            if(result == 0){
                print(result)
                numberDisplayLabel.text! = String(Int(ceil(result)))
                currentNum = Double(numberDisplayLabel.text!)!
            }else{
                result = result / 100
                print(result)
                numberDisplayLabel.text! = String(result)
                currentNum = Double(numberDisplayLabel.text!)!
            }
            
        case divBtn:
            option = "/"
            checkState(currentState, btn: 1)
            operatorDisplayLabel.text! = String(lastNum) + divBtn.titleLabel!.text!
        case mulBtn:
            option = "*"
            checkState(currentState, btn: 1)
            operatorDisplayLabel.text! = String(lastNum) + mulBtn.titleLabel!.text!
        case minBtn:
            option = "-"
            checkState(currentState, btn: 1)
            operatorDisplayLabel.text! = String(lastNum) + minBtn.titleLabel!.text!
        case plusBtn:
            option = "+"
            checkState(currentState, btn: 1)
            operatorDisplayLabel.text! = String(lastNum) + plusBtn.titleLabel!.text!
        case eqBtn:
//            print("eq!")
//            print(currentState)
            checkState(currentState, btn: 2)
            operatorDisplayLabel.text! = String(lastNum) + getOperatorChar(option)
//            numberDisplayLabel.text! = eqBtn.titleLabel!.text!
        default :
            numberDisplayLabel.text! = numberDisplayLabel.text!
        }
        
    }
    
    //function to get operator characters
    
    func getOperatorChar(option: String) ->String{
        switch option{
        case "+":
            return plusBtn.titleLabel!.text!
        case "-":
            return minBtn.titleLabel!.text!
        case "*":
            return mulBtn.titleLabel!.text!
        case "/":
            return divBtn.titleLabel!.text!
        default:
            return "*.*?"
        }
    }
    
    //function to calculate
    func getResult(num1: Double, num2: Double, option: String) ->Double{
        var result = 0.0
        switch option{
        case "+":
            result = num1 + num2
        case "-":
            result = num1 - num2
        case "*":
            result = num1 * num2
        case "/":
            result = num1 / num2
        default:
            break
        }
        return result;
    }
    
    //State machine with 4 state
    //btn: 0 for num, 1 for operators, 2 for eq
    func checkState(state:Int, btn: Int){
        print("this is state", state)
        switch state{
        case 0:
            if(btn==0){
                currentState = 0
            }else if(btn == 1){
                lastNum = currentNum
                numberDisplayLabel.text! = ""
                currentState = 1
            }else if(btn == 2 ){
                if(option == ""){
                    return
                }else{
                    lastNum = getResult(lastNum, num2: currentNum, option: option)
                    currentNum = lastNum
                    numberDisplayLabel.text! = String(currentNum)
                    currentState = 3
                }

            }
        case 1:
            if(btn == 0){
                currentState = 2
            }else if(btn == 1){
                currentState = 1
                numberDisplayLabel.text! = ""
            }else if(btn == 2){
                if(option == ""){
                    return
                }else{
                    lastNum = getResult(lastNum, num2: currentNum, option: option)
                    currentNum = lastNum
                    numberDisplayLabel.text! = String(currentNum)
                    currentState = 3
                }
            }
        case 2:
            if(btn == 0){
                lastNum = Double(numberDisplayLabel.text!)!
                currentState = 2
            }else if( btn == 1 ){
                lastNum = getResult(lastNum, num2: currentNum, option: option)
                currentNum = lastNum
                numberDisplayLabel.text! = ""
                currentState = 0
            }else if( btn == 2){
                lastNum = getResult(lastNum, num2: currentNum, option: option)
                currentNum = lastNum
                numberDisplayLabel.text! = String(currentNum)
                currentState = 3
            }
        case 3:
            if(btn == 0){
                lastNum = 0.0
                numberDisplayLabel.text! = ""
                currentState = 0
            }else if(btn == 1){
                lastNum = currentNum
                numberDisplayLabel.text! = ""
                currentState = 1
            }else if(btn == 2 ){
                if(option == ""){
                    return
                }else{
                    lastNum = getResult(lastNum, num2: currentNum, option: option)
                    currentNum = lastNum
                    numberDisplayLabel.text! = String(currentNum)
                    currentState = 3
                }
            }
        default:
            return
        }
        //for debug
//        print("lastNum", lastNum)
//        print("currentNum", currentNum)
//        print("option", option)
//        print("currentState",currentState)
    }
}

