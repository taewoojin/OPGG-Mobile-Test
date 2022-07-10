//
//  Matches.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//


struct Matches: Decodable, Hashable {
    let games: [Game]
    let champions: [GameChampion]
    let positions: [GamePosition]
    let summary: GameSummary
}
