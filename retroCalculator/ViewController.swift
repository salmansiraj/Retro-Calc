//
//  ViewController.swift
//  retroCalculator
//
//  Created by salman siraj on 12/31/18.
//  Copyright © 2018 salman siraj. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    @IBOutlet weak var outerDisplay: UIStackView!
    @IBOutlet weak var numberDisplay: UIStackView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var retroCalc: UIView!
    @IBOutlet weak var startbutton: UIButton!
    @IBOutlet weak var Outputlabel: UILabel!
    
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var numberOne  = ""
    var numberTwo  = ""
    var result = ""
    
    
    enum Operation : String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = ""
    }
    
    var currOperator: Operation = Operation.Empty
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl as URL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed( keyHit : UIButton! ) {
        playSound()
        
        runningNumber +=  "\(keyHit.tag)" // Adds inputnumber to the running number
        outputLbl.text = runningNumber
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currOperator != Operation.Empty {
            if runningNumber != "" {
                numberTwo = runningNumber
                runningNumber = ""
                
                if currOperator == Operation.Multiply {
                    result = "\(Double(numberOne)! * Double(numberTwo)!)"
                }
                else if currOperator == Operation.Add {
                    result = "\(Double(numberOne)! + Double(numberTwo)!)"
                }
                else if currOperator == Operation.Subtract {
                    result = "\(Double(numberOne)! - Double(numberTwo)!)"
                }
                else {
                    result = "\(Double(numberOne)! / Double(numberTwo)!)"
                }
                numberOne = result
                outputLbl.text = result
            }
        }
        else {
            numberOne = runningNumber
            runningNumber = ""
        }
        currOperator = op
    }
    
    @IBAction func addPressed(sender: AnyObject) {
        processOperation(op: Operation.Add)
    }
    
    @IBAction func subtractPressed(sender: AnyObject) {
        processOperation(op: Operation.Subtract)
    }
    
    @IBAction func dividePressed(sender: AnyObject) {
        processOperation(op: Operation.Divide)
        
    }
    
    @IBAction func equalPressed(sender: AnyObject) {
        processOperation(op: currOperator)
    }
    
    @IBAction func multiplyPressed(sender: AnyObject) {
        processOperation(op: Operation.Multiply)
    }
    
    
    @IBAction func clearPressed(sender: AnyObject) {
        playSound()
        runningNumber = ""
        numberOne  = ""
        numberTwo  = ""
        result = ""
        currOperator = Operation.Empty
        outputLbl.text = "0"
    }
    
    @IBAction func StartButtonPressed(sender: UIButton) {
        playSound()
        startbutton.isHidden = true
        retroCalc.isHidden = true
        outerDisplay.isHidden = false
        numberDisplay.isHidden = false
        clearButton.isHidden = false
        Outputlabel.isHidden = false
    }
    
    
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }

}

