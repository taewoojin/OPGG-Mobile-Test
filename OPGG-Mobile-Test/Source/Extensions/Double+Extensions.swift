//
//  Double+Extensions.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//

import Foundation
import UIKit

extension Double {
    
    static func kda(kill: Double, death: Double, assist: Double) -> Double {
        let digit: Double = pow(10, 2)
        let kda = (kill + assist) / death
        return (kda * digit).rounded() / digit
    }
    
    public func round(decimal: Int) -> Double {
        let digit = Double(truncating: pow(10, decimal) as NSNumber)
        return (self * digit).rounded() / digit
    }
    
}
