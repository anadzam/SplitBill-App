//
//  ViewController.swift
//  SplitBill
//
//  Created by Ana Dzamelashvili on 6/6/22.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
                
                zeroPctButton.isSelected = false
                tenPctButton.isSelected = false
                twentyPctButton.isSelected = false
                sender.isSelected = true
                
                let buttonTitle = sender.currentTitle!
                let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
                let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
                tip = buttonTitleAsANumber / 100

        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //my solution
        //splitNumberLabel.text = Int(sender.value).description
        
        //better found in google
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
        
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
                if bill != "" {
                    billTotal = Double(bill)!
                    let result = billTotal * (1 + tip) / Double(numberOfPeople)
                    finalResult = String(format: "%.2f", result)
                }
                
                //In Main.storyboard there is a segue between CalculatorVC and ResultsVC with the identifier "goToResults".
                //This line triggers the segue to happen.
                self.performSegue(withIdentifier: "goToResults", sender: self)
           }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            //If the currently triggered segue is the "goToResults" segue.
            if segue.identifier == "goToResults" {
                
                //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
                let destinationVC = segue.destination as! ResultsViewController
                
                //Set the destination ResultsViewController's properties.
                destinationVC.result = finalResult
                destinationVC.tip = Int(tip * 100)
                destinationVC.split = numberOfPeople
            }
        }
    
    
}

