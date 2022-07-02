//
//  SummonerRouter.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//

import Foundation

import Moya


enum SummonerRouter {
    case fetchSummonerInfo
    case fetchGameInfo(Int)
    
}

extension SummonerRouter: TargetType {
    public var baseURL: URL {
        switch self {
        default: return URL(string: Constant.default.domain.url)!
        }
    }

    public var method: Moya.Method {
        switch self {
        default: return .get
        }
    }

    public var path: String {
        switch self {
        case .fetchSummonerInfo:
            return "/summoner/genetory"
            
        case .fetchGameInfo:
            return "/summoner/genetory/matches"
        }
    }

    var parameters: [String: Any] {
        switch self {
        case .fetchGameInfo(let createDate):
            return [
                "lastMatch": createDate
            ]
            
        default: return [:]
        }
    }

    public var task: Task {
        switch self {
        case .fetchGameInfo:
            return .requestParameters(
                parameters: self.parameters,
                encoding: URLEncoding.queryString
            )
            
        default:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        switch self {
        default: return ["Content-Type": "application/json"]
        }
    }
    
}
