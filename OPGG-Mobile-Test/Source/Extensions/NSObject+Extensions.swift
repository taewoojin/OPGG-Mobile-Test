//
//  NSObject+Extensions.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/07.
//

import Foundation


extension NSObject {
    
    static var typeName: String {
        return String(describing: self)
    }
    
    public func className() -> String {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }
    
}
