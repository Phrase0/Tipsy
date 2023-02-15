//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var tip = 0.10
    var numberOfPeople = 2
    var resultTo2DecimalPlaces = ""
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        //選中按鈕
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        //從標題中刪除最後一個字符 (%)，然後將其變回字符串。
        //https://stackoverflow.com/questions/24122288/remove-last-character-from-string-swift-language
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        
        //從String轉為Double
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        //將 100 的百分比除以小數，例如 10 變成 0.1
        tip = buttonTitleAsANumber / 100
        
        //關閉鍵盤
        billTextField.endEditing(true)
        
    }
    
    //收鍵盤
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    //按下加號減號改變人數的方法
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //Use stepper as increaser/decreaser in Swift
        //https://stackoverflow.com/questions/38242758/use-stepper-as-increaser-decreaser-in-swift
        splitNumberLabel.text = Int(sender.value).description
        numberOfPeople = Int(sender.value)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let cost = (Double(billTextField.text!) ?? 0.0) * (1 + tip) / Double(numberOfPeople)
        
        resultTo2DecimalPlaces = String(format: "%.0f", cost)
        
        performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            if let destinationVC = segue.destination as? ResultsViewController{
                destinationVC.result = resultTo2DecimalPlaces
                destinationVC.tip = Int(tip * 100)
                destinationVC.split = numberOfPeople
            }
        }
    }
    
    
}

