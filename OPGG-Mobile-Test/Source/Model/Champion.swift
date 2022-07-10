//
//  Champion.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//


struct GameChampion: Decodable, Hashable, Comparable {
    let name: String
    let imageUrl: String
    let games: Int
    let kills: Int
    let deaths: Int
    let assists: Int
    let wins: Int
    let losses: Int
    
    let winningRate: Int
    
    
    enum CodingKeys: String, CodingKey {
        case name, imageUrl, games, kills, deaths, assists, wins, losses
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
        games = try values.decode(Int.self, forKey: .games)
        kills = try values.decode(Int.self, forKey: .kills)
        deaths = try values.decode(Int.self, forKey: .deaths)
        assists = try values.decode(Int.self, forKey: .assists)
        wins = try values.decode(Int.self, forKey: .wins)
        losses = try values.decode(Int.self, forKey: .losses)
        
        winningRate = Int.winningRate(wins: wins, losses: losses)
    }
    
    static func < (lhs: GameChampion, rhs: GameChampion) -> Bool {
        return lhs.winningRate > rhs.winningRate
    }
}
