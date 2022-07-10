//
//  AnalysedSummoner.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//

import CoreGraphics


/// 소환사의 게임 정보 분석 모델
struct AnalysedSummoner: Hashable {
    let summary: GameSummary
    let kda: Double
    let winningRate: Int
    let mostChampions: [GameChampion]
    let mostPosition: GamePosition?
    
    let averageKills: Double
    let averageDeaths: Double
    let averageAssists: Double
    
    
    init(summary: GameSummary, champions: [GameChampion], positions: [GamePosition]) {
        self.summary = summary
        
        let totalMatches = Double(summary.wins + summary.losses)
        self.averageKills = (Double(summary.kills) / totalMatches).round(decimal: 1)
        self.averageDeaths = (Double(summary.deaths) / totalMatches).round(decimal: 1)
        self.averageAssists = (Double(summary.assists) / totalMatches).round(decimal: 1)
        
        self.kda = Double.kda(kill: averageKills, death: averageDeaths, assist: averageAssists)
        self.winningRate = Int.winningRate(wins: summary.wins, losses: summary.losses)
        
        self.mostChampions = champions.sorted().chunked(into: 2).first ?? []
        self.mostPosition = positions.sorted().first
    }
}
