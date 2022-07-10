//
//  BaseError.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//


protocol BaseError: Error {
    var errorDescription: String? { get }
}
