//
//  SummonerViewModel.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//

import RxCocoa
import RxSwift


class SummonerViewModel {
    
    enum Action {
        case fetchSummonerInfo
        case fetchGameInfo(Int)
    }
    
    enum Mutation {
        case setSummonerInfo(Summoner)
        case setGames([Game])
    }
    
    struct Store {
        var summonerInfo: Summoner?
        var games: [Game] = []
    }
    
    
    // MARK: Properties
    
    var disposeBag = DisposeBag()
    
    private(set) var store: Store
    
    let action = PublishRelay<Action>()
    
    lazy var currentStore = BehaviorRelay<Store>(value: store)
    
    let service: SummonerServiceProtocol
    
    
    // MARK: Initializing
    
    init(service: SummonerServiceProtocol = SummonerService()) {
        self.service = service
        self.store = Store()
        
        action
            .flatMap(mutate)
            .flatMap(reduce)
            .bind(to: currentStore)
            .disposed(by: disposeBag)
    }
    
    private func mutate(_ action: Action) -> Observable<Mutation> {
        switch action {
            
        case .fetchSummonerInfo:
            return service
                .fetchSummonerInfo()
                .asObservable()
                .flatMap { result -> Observable<Mutation> in
                    switch result {
                    case .success(let info):
                        return .empty()
                        
                    case .failure(let error):
                        // TODO: 상황에 따른 에러 처리
                        return .empty()
                        
                    }
                }
            
        case .fetchGameInfo(let createDate):
            return service
                .fetchGameInfo(by: createDate)
                .asObservable()
                .flatMap { result -> Observable<Mutation> in
                    switch result {
                    case .success(let info):
                        return .empty()

                    case .failure(let error):
                        // TODO: 상황에 따른 에러 처리
                        return .empty()

                    }
                }
            
        }
    }
    
    private func reduce(_ mutation: Mutation) -> Observable<Store> {
        switch mutation {
        case .setSummonerInfo(let summoner):
            store.summonerInfo = summoner
            
        case .setGames(let games):
            store.games = games
        
        }
        
        return .just(store)
    }
    
}
