//
//  OPBadge.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//

import UIKit

enum OPBadge: String {
    case mvp = "MVP"
    case ace = "ACE"
    
    var color: UIColor {
        switch self {
        case .mvp: return #colorLiteral(red: 1, green: 0.662745098, blue: 0.01960784314, alpha: 1)
        case .ace: return #colorLiteral(red: 0.5450980392, green: 0.4078431373, blue: 1, alpha: 1)
        }
    }
}
