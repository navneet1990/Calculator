//
//  InputValidatorManager.swift
//  Calculator
//
//  Created by Navneet Singh on 7/12/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.co,). All rights reserved.
//

import Foundation

class InputValidatorManager{
    
    private  var inputString : [String]
    
    init (_ inputString: [String]){
        
        self.inputString = inputString
    }
    
    func beginOperation()-> Bool{
        Operators.operandList.removeAll()
        Operators.operatorList.removeAll()
        return validateInputEntered()
    }
}
// Private functions
private extension InputValidatorManager{
    
    // Validate the entered input
    func validateInputEntered() -> Bool{
        do{
            try validateInput()
            for i in 0..<inputString.count {
                if isOperand(index:i) {
                    Operators.operandList.append( try Fraction(inputString[i]))
                }
                else if isOperator(index: i){
                    Operators.operatorList.append(inputString[i])
                }
            }
            // Begin calculation here
         return CalculationManager.performCalculation()
            
        } catch ProgramError.invalidInput {
            print("Invalid input! Format should be \"[number] [operator number ...]\". Operators include no other than +,-,x,/.")
            exit(1)
        } catch ProgramError.divisionByZero {
            print("Invalid input: Division by 0!")
            exit(3)
        } catch {
            print("Unexpected error!")
            exit(3)
        }
        return false
    }
    
    //Validate for Operand
    func isOperand(index: Int) -> Bool {
        let type = inputString[index].validateFractionType()
        guard  type != .none else {
            return false
        }
        return true
    }
    
    //Validate for Operator
    func isOperator(index: Int) -> Bool {
        switch inputString[index] {
        case "+", "-", "*", "/":
            return true
        default:
            return false
        }
    }
    
    // Validate For Fraction
    func isFraction(index:Int)-> Bool{
        guard inputString[index].intValue != nil else {
            return false
        }
        return true
    }
    
    //Check if input is valid
    func validateInput()throws{
        var i = 1
        guard isOperand(index: 0) && inputString.count % 2 != 0 else {
            throw ProgramError.invalidInput
        }
        // Validate input string order operator followed by operand
        while i < inputString.count - 1 {
            guard isOperator(index: i) && isOperand(index: i + 1) else {
                throw ProgramError.invalidInput
            }
            i += 2
        }
    }
    
}

