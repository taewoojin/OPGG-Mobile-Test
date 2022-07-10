//
//  ImageError.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//


enum ImageError: BaseError {
    case loadFailed
    
    var errorDescription: String? {
        switch self {
        case .loadFailed: return "이미지를 로드하지 못했습니다."
        }
    }
}
