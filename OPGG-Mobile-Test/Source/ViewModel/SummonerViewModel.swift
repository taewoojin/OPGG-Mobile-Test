//
//  SummonerViewModel.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//

import RxCocoa
import RxSwift


final class SummonerViewModel {
    
    enum Action {
        case fetchSummonerInfo
        case fetchMatches
        case fetchMoreMatches(Double)
    }
    
    enum Mutation {
        case setSummonerInfo(Summoner)
        case setLeagues([League])
        case setAnalysis(AnalysedSummoner)
        case setGames([Game])
        case setError(ResponseError)
    }
    
    struct Store {
        var sections: [Section] = [
            Section(type: .info, items: []),
            Section(type: .league, items: []),
            Section(type: .analysis, items: []),
            Section(type: .game, items: [])
        ]
        
        var games: [Game] = []
        var error: ResponseError?
    }
    
    
    // MARK: Properties
    
    private var disposeBag = DisposeBag()
    
    private(set) var store: Store
    
    let action = PublishRelay<Action>()
    
    lazy var currentStore = BehaviorRelay<Store>(value: store)
    
    private let service: SummonerServiceProtocol
    
    
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
                    case .success(let summoner):
                        return .merge(
                            .just(.setSummonerInfo(summoner)),
                            .just(.setLeagues(summoner.leagues))
                        )
                        
                    case .failure(let error):
                        // FIXME: 상황에 따른 에러 처리
                        guard let error = error as? BaseError else { return .empty() }
                        let responseError = ResponseError(message: error.errorDescription)
                        return .just(.setError(responseError))
                    }
                }
            
        case .fetchMatches:
            return service
                .fetchMatches()
                .asObservable()
                .flatMap { result -> Observable<Mutation> in
                    switch result {
                    case .success(let matches):
                        return .merge(
                            .just(.setAnalysis(matches.analysis)),
                            .just(.setGames(matches.games))
                        )

                    case .failure(let error):
                        // FIXME: 상황에 따른 에러 처리
                        guard let error = error as? BaseError else { return .empty() }
                        let responseError = ResponseError(message: error.errorDescription)
                        return .just(.setError(responseError))

                    }
                }
            
        case let .fetchMoreMatches(createDate):
            return service
                .fetchMoreMatches(by: createDate)
                .asObservable()
                .flatMap { result -> Observable<Mutation> in
                    switch result {
                    case .success(let matches):
                        return .just(.setGames(self.store.games + matches.games))

                    case .failure(let error):
                        // FIXME: 상황에 따른 에러 처리
                        guard let error = error as? BaseError else { return .empty() }
                        let responseError = ResponseError(message: error.errorDescription)
                        return .just(.setError(responseError))

                    }
                }
            
        }
    }
    
    private func reduce(_ mutation: Mutation) -> Observable<Store> {
        switch mutation {
        case .setSummonerInfo(let summoner):
            store.sections[0] = Section(type: .info, items: [.info(summoner)])
            
        case let .setLeagues(leagues):
            store.sections[1] = Section(type: .league, items: [.league(leagues)])
            
        case let .setAnalysis(analysis):
            store.sections[2] = Section(type: .analysis, items: [.analysis(analysis)])
            
        case let .setGames(games):
            store.games = games
            store.sections[3] = Section(type: .game, items: games.map({ .game($0) }))
            
        case let .setError(error):
            store.error = error
        }
        
        return .just(store)
    }
    
}
