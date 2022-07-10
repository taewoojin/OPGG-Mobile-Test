//
//  Game.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//


struct Game: Decodable, Hashable {
    let champion: Champion
    let spells: [Spell]
    let items: [Item]
    let createDate: Double
    let gameType: String
    let gameLength: Int
    let isWin: Bool
    let stats: Stats
    let peak: [String]
    
    
    struct Spell: Decodable, Hashable {
        let imageUrl: String
    }
    
    struct Item: Decodable, Hashable {
        let imageUrl: String
    }
    
    struct Champion: Decodable, Hashable {
        let level: Int
        let imageUrl: String
    }
    
    struct Stats: Decodable, Hashable {
        let general: General
        
        struct General: Decodable, Hashable {
            let kill: Int
            let death: Int
            let assist: Int
            let opScoreBadge: OPBadge?
            let contributionForKillRate: String     // 킬 관여율
            let largestMultiKillString: String
            
            enum CodingKeys: String, CodingKey {
                case kill, death, assist, opScoreBadge, contributionForKillRate, largestMultiKillString
            }
            
            init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                kill = try values.decode(Int.self, forKey: .kill)
                death = try values.decode(Int.self, forKey: .death)
                assist = try values.decode(Int.self, forKey: .assist)
                
                let opBadgeString = try values.decode(String.self, forKey: .opScoreBadge)
                opScoreBadge = OPBadge(rawValue: opBadgeString) ?? nil
                
                contributionForKillRate = try values.decode(String.self, forKey: .contributionForKillRate)
                largestMultiKillString = try values.decode(String.self, forKey: .largestMultiKillString)
            }
        }
    }
}
