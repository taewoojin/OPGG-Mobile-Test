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

struct League: Decodable, Hashable {
    let wins: Int
    let losses: Int
    let tierRank: TierRank
}

struct TierRank: Decodable, Hashable {
    let name: String        // 게임타입
    let imageUrl: String
}
