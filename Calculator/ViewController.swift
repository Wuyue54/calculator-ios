//
//  ViewController.swift
//  Calculator
//
//  Created by Yanpu Wu on 9/10/16.
//  Copyright © 2016 Yanpu Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var result = 0.0

    @IBOutlet weak var numberDisplayLabel: UILabel!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numPadPressedAction(sender: UIButton) {
        let result = numberDisplayLabel.text!
        switch sender{
        case btn0:
            if (Double(result) == 0){
                return
            }else{
                numberDisplayLabel.text! += "0"
            }
        case btnDot:
            if(result.containsString(".")){
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
    }

    @IBAction func operatorPressedAction(sender: UIButton) {
//        numberDisplayLabel.text! += sender.titleLabel!.text!
        var result = Double(numberDisplayLabel.text!)!
              switch sender {
        case clearBtn:
            numberDisplayLabel.text! = "0"
        case PosNegBtn:
            if(result>0){
                numberDisplayLabel.text! = "-"+String(result)
            }else{
                result = -result
                numberDisplayLabel.text! = String(result)
            }
//            numberDisplayLabel.text! = PosNegBtn.titleLabel!.text!
        case percentBtn:
            result = result / 100
            numberDisplayLabel.text! = String(result)
        case divBtn:
            numberDisplayLabel.text! = divBtn.titleLabel!.text!
        case mulBtn:
            numberDisplayLabel.text! = mulBtn.titleLabel!.text!
        case minBtn:
            numberDisplayLabel.text! = minBtn.titleLabel!.text!
        case plusBtn:
            numberDisplayLabel.text! = plusBtn.titleLabel!.text!
        case eqBtn:
            numberDisplayLabel.text! = eqBtn.titleLabel!.text!
        default :
            numberDisplayLabel.text! = numberDisplayLabel.text!
        }
    }
}

