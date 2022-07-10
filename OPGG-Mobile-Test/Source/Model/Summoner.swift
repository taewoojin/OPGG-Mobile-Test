//
//  Summoner.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//


struct Summoner: Decodable, Hashable {
    let name: String
    let level: Int
    let profileImageUrl: String
    let leagues: [League]
}
