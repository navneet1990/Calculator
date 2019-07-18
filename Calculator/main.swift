//
//  main.swift
//  Calculator
//
//  Created by Navneet Singh on 18/07/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.co,). All rights reserved.
//

import Foundation

let isTesting = true // On true, arguements will be passed from schema

func begin(){
    var userInput: [String] = []
    let readPrompt = CommandLine.arguments
    if isTesting && readPrompt.count > 1{
        userInput = Array(readPrompt.dropFirst())
        print("Default input: %@", userInput)
    }
    else {
        print("Please enter operand and operator")
        let response = readLine()
        let list = response?.components(separatedBy: " ").filter { $0 != ""}
        guard let input = list , input.count > 0 else {
            print("Invalid input")
            return
        }
        userInput = input
    }
    let validator = InputValidatorManager( userInput )
    let success = validator.beginOperation()
    
    // Ask user if he wants to exist or continue , but testing must be false to continue
    if success && !isTesting{
        print("Press \"y\" to continue or \"n\" to finish")
        if  "y" == readLine()?.lowercased(){ begin()}
        else{
            print("Program finished")
        }
        
    }
}
begin()

