//
//  Int+Extensions.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//

import UIKit

extension Int {

    static func winningRate(wins: Int, losses: Int) -> Int {
        guard wins > 0 || losses > 0 else { return 0 }
        return Int(round(CGFloat(wins) / CGFloat(wins + losses) * 100))
    }
    
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
    
}
