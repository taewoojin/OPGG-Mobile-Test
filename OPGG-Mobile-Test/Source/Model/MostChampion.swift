//
//  MostChampion.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//


struct MostChampion: Decodable, Hashable {
    let name: String
    let imageUrl: String
    let games: Int
    let kills: Int
    let deaths: Int
    let assists: Int
    let wins: Int
    let losses: Int
}
