//
//  Extensions.swift
//  Calculator
//
//  Created by Navneet Singh on 7/16/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.co,). All rights reserved.
//

import Foundation

extension String{
    public var intValue: Int?{
        return Int(self)
    }
    public func isFactionalNumber()-> String? {
        
        
        let list = self.split(separator: "/")
        if list.count == 2{
            if let numerator = Int(list.first!), let dom = Int(list.last!), numerator % dom == 0{
                let final = numerator / dom
                return String(final)
            }
            return self
        }
        return nil
        
    }
    
    func validateFractionType() -> FractionType {
        let list = self.split(separator: "/")
        if list.count == 2{
            if list.first?.split(separator: "_").count == 2{
                return .mixed
            }
            return .proper
        }
        
        guard self.intValue != nil else {
            return .none
        }
        return .wholeNumber
    }
    
    func convertStringTOFrac()-> (Int?,Int,Int){
        let list = self.split(separator: "/")
        if list.count == 2, let den = list.last?.intValue{
            if let expand = list.first?.split(separator: "_"),expand.count == 2, let improperNum = expand.first, let num = expand.last?.intValue {
                
                return (improperNum.intValue,num,den)
            }
            return (nil, list.first?.intValue ?? 1 ,den )
        }
        return (nil,self.intValue ?? 1 ,1)
        
    }
    
}

extension String.SubSequence{
    
    var intValue: Int?{
        
        let newValue = String(self).intValue
        return newValue
    }
}

extension Fraction{
    public func showAsMixedFracString() -> String{
        if denominator == 1 {
            return "\(numerator)"
        }
        guard let result = generateMixedFraction() else{
            return "\(numerator)/\(denominator)"
        }
        return "\(result.left)" + "_" + "\(result.num)" + "/" + "\(denominator)"
    }
    
    private func generateMixedFraction()-> (left : Int, num: Int)? {
        let mod = numerator % denominator
        guard  mod > 0 else {
            return nil
        }
        let num = numerator - mod
        let lhs = num / denominator
        return (lhs, mod)
    }
}
