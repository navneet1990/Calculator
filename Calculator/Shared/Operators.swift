//
//  Operators.swift
//  Calculator
//
//  Created by Navneet Singh on 7/16/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.co,). All rights reserved.
//

import Foundation

class Operators {
    
    static var operandList : [Fraction] = []
    static var operatorList : [String] = []
    
    
    var index: Int
    var operatorType: OperatorType
    
    // Initializer
    init (index: Int) throws  {
        self.index = index
        guard let op = OperatorType.init(rawValue: Operators.operatorList[index]) else {
            throw ProgramError.invalidOperator
        }
        self.operatorType = op
    }
    // Next operator
    func next()throws -> Operators {
        return try Operators(index: index + 1)
    }
    // Check order of operators
    func precedence() -> Int  {
        switch operatorType {
        case .add, .substract:
            return 1
        case .multiply, .divide:
            return 2
        }
    }
    // Perform calculation based upon operator
    func performOperation(a: Fraction, b: Fraction) throws -> Fraction {
        
        switch operatorType {
        case   .add , .substract :
            return try addSubstract( a, b)
        case .multiply:
            return try multiply(a, b)
            
        case .divide:
            return try divide( a, b)
        }
    }
    // Perform Add/Substract operation
    private func addSubstract(_ lhs: Fraction, _ rhs: Fraction) throws -> Fraction{
        let calulatedDenomin = Fraction.commonDenominator( lhs, rhs)
        if operatorType == .add {
            let add = calulatedDenomin.lhsNumerator + calulatedDenomin.rhsNumberator
            if add > Int.max || add < Int.max * -1 {
                throw ProgramError.outOfBounds
            }
            let result = try Fraction("\(add)/\(calulatedDenomin.denominator)")
            return result
            
        }
        else{
            let substract = calulatedDenomin.lhsNumerator - calulatedDenomin.rhsNumberator
            if substract > Int.max || substract < Int.max * -1 {
                throw ProgramError.outOfBounds
            }
            let result = try Fraction("\(substract)/\(calulatedDenomin.denominator)")
            return result
            
        }
        
    }
    // Perform Multiple operation
    private func multiply(_ lhs :Fraction, _ rhs: Fraction) throws -> Fraction{
        let multiplyNumerator = lhs.numerator * rhs.numerator
        let multiplyDenom = lhs.denominator * rhs.denominator
        
        let result = try Fraction("\(multiplyNumerator)/\(multiplyDenom)")
        
        if (result.numerator > Int.max || result.numerator < Int.max * -1 ) || (result.denominator > Int.max || result.denominator < Int.max * -1 )  {
            throw ProgramError.outOfBounds
        }
        return result
    }
    
    // Perform Divide operation
    private func divide(_ lhs :Fraction, _ rhs: Fraction) throws -> Fraction{
        
        if lhs.denominator == 0 || rhs.numerator == 0 {
            throw ProgramError.divisionByZero
        }
        let multiplyNumerator = lhs.numerator * rhs.denominator
        let multiplyDenom = lhs.denominator * rhs.numerator
        let result = try Fraction("\(multiplyNumerator)/\(multiplyDenom)")
        return result
    }
    
}
