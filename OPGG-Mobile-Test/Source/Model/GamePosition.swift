//
//  GamePosition.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//

import UIKit


struct GamePosition: Decodable, Hashable {
    let games: Int
    let wins: Int
    let losses: Int
    let positionName: String
    let positionType: GamePositionType?
    
    let winningRate: Int
    
    enum CodingKeys: String, CodingKey {
        case games
        case wins
        case losses
        case positionName
        case positionType = "position"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        games = try values.decode(Int.self, forKey: .games)
        wins = try values.decode(Int.self, forKey: .wins)
        losses = try values.decode(Int.self, forKey: .losses)
        positionName = try values.decode(String.self, forKey: .positionName)
        
        let typeString = try values.decode(String.self, forKey: .positionType)
        positionType = GamePositionType(rawValue: typeString)
        
        winningRate = Int.winningRate(wins: wins, losses: losses)
    }
}

extension GamePosition: Comparable {
    static func < (lhs: GamePosition, rhs: GamePosition) -> Bool {
        return lhs.winningRate > rhs.winningRate
    }
}

enum GamePositionType: String, Decodable, Hashable {
    case top = "TOP"
    case jungle = "JNG"
    case middle = "MID"
    case bottom = "ADC"
    case support = "SUP"
    case all = "ALL"
    
    var image: UIImage? {
        switch self {
        case .top: return UIImage(named: "iconLolTop")
        case .jungle: return UIImage(named: "iconLolJng")
        case .middle: return UIImage(named: "iconLolMid")
        case .bottom: return UIImage(named: "iconLolBot")
        case .support: return UIImage(named: "iconLolSup")
        case .all: return UIImage(named: "iconLolAll")
        }
    }
}


