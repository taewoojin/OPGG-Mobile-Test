//
//  GameSummary.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//


struct GameSummary: Decodable, Hashable {
    let wins: Int
    let losses: Int
    let kills: Int
    let deaths: Int
    let assists: Int
}
