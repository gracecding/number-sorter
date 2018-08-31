//
//  ViewController.swift
//  Number Sorter
//
//  Created by Grace Ding on 6/22/18.
//  Copyright © 2018 Grace Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numbersTextField: UITextField!
    
    @IBOutlet weak var sortedNumbersLabel: UILabel!
    
    @IBOutlet weak var orderSelector: UISegmentedControl!

    
    @IBOutlet weak var meanLabel: UILabel!
    @IBOutlet weak var medianLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    
    
    @IBAction func sortNumbers(_ sender: Any) {
        //var numbers = numbersTextField.text as! Array
        //print numbers
        
//         if let numbers = Double(numbersTextField.text!) {
//            print("Success")
//            //sortedNumbersLabel.text = numbers
//        }
        if let numbers = numbersTextField.text {
            //Split text wherever there is a space
            let numbersArray = numbers.split(separator: " ")
        
            //Create array that contains sortedNumbers
            var sortedNumbers = [Double]()
            
            for possibleNumber in numbersArray {
                //Check if text is a number
                if let number = Double(possibleNumber) {
                    
                    //Check for order requested (ascending or descending)
                    switch orderSelector.selectedSegmentIndex {
                    case 0: //Ascending
                        //Add number to and sort array
                        sortedNumbers.append(number)
                        sortedNumbers = sortedNumbers.sorted { $0 < $1 }
                        
                    case 1: //Descending
                        //Add number to and sort array
                        sortedNumbers.append(number)
                        sortedNumbers = sortedNumbers.sorted { $0 > $1 }

                    default: //Should never happen
                        break
                    }
                    
                    //Display sorted numbers in label
                    var sortedNumbersString = ""
                    for sortedNumber in sortedNumbers {
                        sortedNumbersString += String(sortedNumber) + " "
                    }
                    sortedNumbersLabel.text = sortedNumbersString

                }
                    
                else if numbersTextField.text == "" {
                    print("empty")
                }
                    
                else {
                    let alert = UIAlertController(title: "Input contains non-numbers", message: "Please enter only numbers and spaces", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    
                    return
                }
            }
            //Find and display mean
            var sum = 0.0
            for sortedNumber in sortedNumbers {
                sum += sortedNumber
            }
            
            var mean = sum / Double(sortedNumbers.count)
            meanLabel.text = "Mean: " + String(mean)
            
            //Find and display median
            
            //Array contains an even amount of numbers
            if sortedNumbers.count % 2 == 0 {
                //Find the two middle numbers
                var middleNumber1 = sortedNumbers[(sortedNumbers.count / 2) - 1]
                var middleNumber2 = sortedNumbers[sortedNumbers.count / 2]
                
                //Average the two middle numbers to find the median
                var median = (middleNumber1 + middleNumber2) / 2
                medianLabel.text = "Median: " + String(median)
            }
            
            //Array contains an odd amount of numbers
            else {
                var median = sortedNumbers[sortedNumbers.count / 2]
                medianLabel.text = "Median: " + String(median)
            }
            
            //Find and display mode
            //Number of times the potential mode occurs
            var modeCount = 0
            //Number of times the current number occurs
            var currentCount = 0
            var mode = 0.0
            
            for sortedNumber in sortedNumbers {

                //Compare every number with each other and count how many instances of the current number there are
                for potentialMode in sortedNumbers {
                    if sortedNumber == potentialMode {
                        currentCount += 1
                    }
                    
                    //If the current number occurs more than the previous "mode," the mode becomes the current number
                    if currentCount > modeCount {
                        modeCount = currentCount
                        mode = potentialMode
                    }
                }
    
            }
            

            modeLabel.text = "Mode: "  + String(mode)
            
            
            //Find and display range
            let min = sortedNumbers.min()
            let max = sortedNumbers.max()
            let range = max! - min!
            rangeLabel.text = "Range: " + String(range)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortedNumbersLabel.sizeToFit()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

