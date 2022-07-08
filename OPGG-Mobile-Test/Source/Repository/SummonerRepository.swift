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
    func fetchGameInfo(by createDate: Int) -> Single<Result<GameOfSummoner, Error>>
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
    
    func fetchGameInfo(by createDate: Int) -> Single<Result<GameOfSummoner, Error>> {
        return provider.rx
            .request(.fetchGameInfo(createDate))
            .map { response in
                let jsonString = String(data: response.data, encoding: .utf8)
//                print("json: ", jsonString)
                return response
            }
            .asResult(GameOfSummoner.self)
    }
    
}
