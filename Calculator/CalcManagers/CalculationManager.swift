//
//  CalculationManager.swift
//  Calculator
//
//  Created by Navneet Singh on 7/17/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.co,). All rights reserved.
//

import Foundation

class CalculationManager {
    
    // Validate for Calculation Error
    static func performCalculation()-> Bool{
        do {
         let result = try calculate(i: 0)
             print(result.showAsMixedFracString())
            return true
        } catch ProgramError.divisionByZero {
            print("Error: Division by 0!")
            exit(2)
        } catch ProgramError.invalidOperator{
            print("Invalid Operator.. Please enter correct input")
            
        } catch ProgramError.outOfBounds {
            print("Error: Numeric out of bounds!")
            exit(2)
        } catch {
            print("Unexpected error!")
            exit(3)
        }
        return false
    }
    private static func calculate(i: Int, minPrec: Int = 1) throws -> Fraction{
        
        var lhs = Operators.operandList[i]
        var rhs : Fraction
        
        if Operators.operatorList.count == 0 {
            return lhs
        }
        var op = try Operators(index: i)
        var nextOp: Operators
        
        while  op.precedence() >= minPrec {
            if op.index == Operators.operatorList.count - 1 {
                return try op.performOperation(a: lhs, b: Operators.operandList[Operators.operandList.count - 1])
            }// if current operator is the last operator, compute lhs with the last number and return, else advance to next operator
            
            nextOp = try op.next()
            rhs = try calculate(i: op.index + 1, minPrec: op.precedence() + 1)// recursive call, start from next operator and climb precedence by 1
            lhs = try (op.performOperation(a: lhs, b: rhs))
            
            //determine the starting operator in next while loop
            if nextOp.precedence() > op.precedence() && nextOp.index < Operators.operatorList.count - 1 {
                while nextOp.precedence() > op.precedence(){
                    if nextOp.index == Operators.operatorList.count - 1 {
                        return lhs
                    }
                    nextOp = try nextOp.next()
                }
                op = nextOp
            }// if next operator's precedence is higher, iterate until finding an operator with the same precedence as the current one
            else if nextOp.precedence() > op.precedence() && nextOp.index == Operators.operatorList.count - 1{
                return lhs
            }
            else {
                op = try op.next()
            }
        }
        
        return lhs
    }
}
