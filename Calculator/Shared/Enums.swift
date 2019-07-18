//
//  Enums.swift
//  Calculator
//
//  Created by Navneet Singh on 7/12/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.co,). All rights reserved.
//

import Foundation

// Error types
enum ProgramError: Error{
    case invalidInput
    case invalidOperator
    case outOfBounds
    case divisionByZero
}
// Fraction types
enum FractionType{
    case proper
    case mixed // 3_1/3
    case wholeNumber
    case none
}

// Opertator types
enum OperatorType: String {
    case add = "+"
    case substract = "-"
    case divide = "/"
    case multiply = "*"
    
}
