//
//  Int+Extensions.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//

import UIKit

extension Int {

    static func winningRate(wins: Int, losses: Int) -> Int {
        return Int(round(CGFloat(wins) / CGFloat(wins + losses) * 100))
    }
    
}
