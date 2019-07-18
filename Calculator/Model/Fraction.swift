//
//  Fraction.swift
//  Calculator
//
//  Created by Navneet Singh on 7/17/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.co,). All rights reserved.
//

import Foundation

public typealias Fraction = Fractional<Int>
public typealias IntegerType = SignedInteger

public struct Fractional<Number: IntegerType> {
    /// The numerator of the fraction.
    public var numerator: Number
    
    /// The (always non-negative) denominator of the fraction.
    public let denominator: Number
    
    // Create an instance initialized to `value`.
    public init(_ value: String) throws {
        let fraction = value.convertStringTOFrac()
        let num = fraction.1 as! Number
        let den = fraction.2 as! Number
        guard den != 0 else {
            throw ProgramError.divisionByZero
        }
        guard let improperFrac = fraction.0 as? Number else {
            self.init(num ,den)
            return
        }
        self.init( improperFrac,num,den)
    }
    // Initializer without denominator
    private init(_ numerator: Number, _ denominator: Number) {
        var (numerator, denominator) = Fraction.reduce(numerator:numerator, denominator: denominator)
        if denominator < 0 { numerator *= -1; denominator *= -1 }
        
        self.numerator = numerator
        self.denominator = denominator
    }
    
    //Initlializer with denominator
    private init(_ improperFrac: Number, _ numerator: Number, _ denominator: Number){
        
        let num = improperFrac * denominator + numerator
        self.init(num,denominator)
    }
    
}
//Class methods
extension Fraction{
    // Reduce the fraction
    static func reduce<Number: IntegerType>(numerator:  Number, denominator:  Number) -> (numerator: Number, denominator: Number) {
        var divisor = gcd(numerator, denominator)
        if divisor < 0 { divisor *= -1 }
        guard divisor != 0 else { return (numerator: numerator, denominator: 0) }
        return (numerator: numerator / divisor, denominator: denominator / divisor)
    }
    
    // Convert fraction that has denominator
    static  func commonDenominator(_ lhs: Fraction, _ rhs: Fraction) -> (lhsNumerator: Int, rhsNumberator: Int, denominator: Int) {
        let denominator = lcm(lhs.denominator, rhs.denominator)
        let lhsNumerator = lhs.numerator * (denominator / lhs.denominator)
        let rhsNumerator = rhs.numerator * (denominator / rhs.denominator)
        
        return (lhsNumerator, rhsNumerator, denominator)
    }
    // Calculate GCD
    private  static func gcd<Number: IntegerType>( _ lhs:  Number , _ rhs:  Number ) -> Number {
        var lhs = lhs
        var rhs = rhs
        while rhs != 0 { (lhs, rhs) = (rhs, lhs % rhs) }
        return lhs
    }
    
    // Calculate LCM
    private static func lcm<Number: IntegerType>(_ lhs: Number, _ rhs: Number) -> Number {
        return lhs * rhs / gcd(lhs, rhs)
    }
}
