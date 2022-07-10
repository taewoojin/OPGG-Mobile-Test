//
//  SummonerService.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//

import Foundation

import Moya
import RxMoya
import RxCocoa
import RxSwift


protocol SummonerServiceProtocol {
    func fetchSummonerInfo() -> Single<Result<Summoner, Error>>
    func fetchGameInfo(by createDate: Double?) -> Single<Result<GameOfSummoner, Error>>
    
    func fetchMatches() -> Single<Result<MatchesOfSummoner, Error>>
    func fetchMoreMatches(by createDate: Double) -> Single<Result<Matches, Error>>
}


struct SummonerService: SummonerServiceProtocol {
    
    let repository: SummonerRepositoryProtocol
    
    
    init(repository: SummonerRepositoryProtocol = SummonerRepository()) {
        self.repository = repository
    }
    
    func fetchSummonerInfo() -> Single<Result<Summoner, Error>> {
        return repository.fetchSummonerInfo()
    }
    
    func fetchGameInfo(by createDate: Double?) -> Single<Result<GameOfSummoner, Error>> {
        return repository.fetchGameInfo(by: createDate)
    }
    
    func fetchMatches() -> Single<Result<MatchesOfSummoner, Error>> {
        return repository.fetchMatches(by: nil)
            .map { result in
                switch result {
                case let .success(matches):
                    let analysis = AnalysedSummoner(
                        summary: matches.summary,
                        champions: matches.champions,
                        positions: matches.positions
                    )
                    return .success(MatchesOfSummoner(analysis: analysis, games: matches.games))
                    
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
    
    func fetchMoreMatches(by createDate: Double) -> Single<Result<Matches, Error>> {
        return repository.fetchMoreMatches(by: createDate)
    }
    
}
