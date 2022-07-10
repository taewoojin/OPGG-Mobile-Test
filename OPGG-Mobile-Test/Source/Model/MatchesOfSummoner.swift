//
//  MatchesOfSummoner.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//


struct MatchesOfSummoner: Hashable {
    let analysis: AnalysedSummoner
    let games: [Game]
}
