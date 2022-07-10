//
//  Date+Extensions.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//

import Foundation


extension Date {
    
    var calculatedElapsedTime: String {
        let diffDate = Calendar.current.dateComponents([.second, .minute, .hour, .day, .weekOfMonth], from: self, to: Date())
        
        if diffDate.weekOfMonth! > 0 {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter.string(from: self)
        } else if diffDate.day! > 0 {
            return "\(diffDate.day!)일 전"
        } else if diffDate.hour! > 0 {
            return "\(diffDate.hour!)시간 전"
        } else if diffDate.minute! > 0 {
            return "\(diffDate.minute!)분 전"
        } else {
            return "\(diffDate.second!)초 전"
        }
    }
}
