//
//  Array+Extensions.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//


extension Array {
    
    public func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
}
