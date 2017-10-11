//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by AmeriHealth Caritas Employee on 9/28/17.
//  Copyright © 2017 Tin Pan Tech. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    @IBOutlet var textField: UITextField!
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)	
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if hour >= 7 && hour <= 18 {
            let redRand = CGFloat(Int(arc4random_uniform(128)) + 128) / 256
            let greenRand = CGFloat(Int(arc4random_uniform(128)) + 128) / 256
            let blueRand = CGFloat(Int(arc4random_uniform(128)) + 128) / 256
            self.view.backgroundColor = UIColor(red:redRand,green: greenRand, blue: blueRand, alpha: 1.0)
        } else {
            let redRand = CGFloat(Int(arc4random_uniform(128))) / 256
            let greenRand = CGFloat(Int(arc4random_uniform(128))) / 256
            let blueRand = CGFloat(Int(arc4random_uniform(128))) / 256
            self.view.backgroundColor = UIColor(red:redRand,green: greenRand, blue: blueRand, alpha: 1.0)
        }
    }
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    } ()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replaceTextHasAlphabetics = string.rangeOfCharacter(from: NSCharacterSet.letters)

        let existingTextHasDecimalSeperator = textField.text?.range(of: ".")
        let replaceTextHasDecimalSeperator = string.range(of: ".")
        
        if (existingTextHasDecimalSeperator != nil &&
            replaceTextHasDecimalSeperator != nil) ||
            replaceTextHasAlphabetics != nil {
            return false
        } else {
            return true
        }
    }
}
