//
//  ViewController.swift
//  Calculator
//
//  Created by Tran Minh Tuan on 11/29/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit
import Expression

class ViewController: UIViewController {
    @IBOutlet weak var formulaInput: UIButton!

    @IBOutlet weak var fomulaLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fomulaLabel.text = ""
        resultLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func inputFormula(_ sender: UIButton) {
        guard let formulaText = fomulaLabel.text else {
            return
        }
        
        guard let senderedText = sender.titleLabel?.text else {
            return
        }
        
        fomulaLabel.text = formulaText + senderedText
    }
    
    @IBAction func clearCalculation(_ sender: UIButton) {
        fomulaLabel.text = ""
        resultLabel.text = ""
    }
    
    @IBAction func calculateAnswer(_ sender: UIButton) {
        guard let formulaText = fomulaLabel.text else {
            return
        }
        let formula: String = formatFormula(formulaText)
        resultLabel.text = evalFormula(formula)
    }
    
    private func formatFormula(_ formula: String) -> String {
        let formatted: String = formula.replacingOccurrences(
            of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
            with: "$1.0",
            options: NSString.CompareOptions.regularExpression,
            range: nil
            ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        return formatted
    }
    
    private func evalFormula(_ formula: String) -> String {
        do {
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            return "inputted formula is not correct"
        }
    }
    
    private func formatAnswer(_ answer: String) -> String {
        let formattedAnswer: String = answer.replacingOccurrences(
            of: "\\.0$",
            with: "",
            options: NSString.CompareOptions.regularExpression,
            range: nil)
        return formattedAnswer
    }
}

