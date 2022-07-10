//
//  SummonerRepository.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift


protocol SummonerRepositoryProtocol {
    func fetchSummonerInfo() -> Single<Result<Summoner, Error>>
    func fetchMatches(by createDate: Double?) -> Single<Result<Matches, Error>>
    func fetchMoreMatches(by createDate: Double) -> Single<Result<Matches, Error>>
}


class SummonerRepository: SummonerRepositoryProtocol {
    
    let provider: MoyaProvider<SummonerRouter>
    
    
    init(provider: MoyaProvider<SummonerRouter> = MoyaProvider<SummonerRouter>()) {
        self.provider = provider
    }
    
    func fetchSummonerInfo() -> Single<Result<Summoner, Error>> {
        return provider.rx
            .request(.fetchSummonerInfo)
            .asResult(Summoner.self, key: "summoner")
    }
    
    func fetchMatches(by createDate: Double?) -> Single<Result<Matches, Error>> {
        return provider.rx
            .request(.fetchMatches(createDate))
            .asResult(Matches.self)
    }
    
    func fetchMoreMatches(by createDate: Double) -> Single<Result<Matches, Error>> {
        return provider.rx
            .request(.fetchMatches(createDate))
            .asResult(Matches.self)
    }
    
}
