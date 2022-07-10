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
    
    static func < (lhs: GameChampion, rhs: GameChampion) -> Bool {
        let lhsWinningRate = Int.winningRate(wins: lhs.wins, losses: lhs.losses)
        let rhsWinningRate = Int.winningRate(wins: rhs.wins, losses: rhs.losses)
        return lhsWinningRate < rhsWinningRate
    }
}
