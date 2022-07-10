//
//  League.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//


struct League: Decodable, Hashable {
    let wins: Int
    let losses: Int
    let tierRank: TierRank
    
    struct TierRank: Decodable, Hashable {
        let name: String        // 게임타입
        let imageUrl: String
        let tier: String
        let lp: Int
    }
}
