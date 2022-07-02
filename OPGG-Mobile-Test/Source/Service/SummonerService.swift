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
    func fetchGameInfo(by createDate: Int) -> Single<Result<GameOfSummoner, Error>>
}


struct SummonerService: SummonerServiceProtocol {
    
    let repository: SummonerRepositoryProtocol
    
    
    init(repository: SummonerRepositoryProtocol = SummonerRepository()) {
        self.repository = repository
    }
    
    func fetchSummonerInfo() -> Single<Result<Summoner, Error>> {
        return repository.fetchSummonerInfo()
    }
    
    func fetchGameInfo(by createDate: Int) -> Single<Result<GameOfSummoner, Error>> {
        return repository.fetchGameInfo(by: createDate)
    }
    
}
