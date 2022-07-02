//
//  GameOfSummoner.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//


struct GameOfSummoner: Decodable, Hashable {
    let games: [Game]
    let champions: [MostChampion]
}
