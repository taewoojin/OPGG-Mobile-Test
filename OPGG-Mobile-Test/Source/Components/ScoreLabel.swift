//
//  ScoreLabel.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/09.
//

import UIKit


final class ScoreLabel: UILabel {
    
    func configure<T>(kill: T, death: T, assist: T) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        let killString = NSMutableAttributedString(string: "\(kill) / ", attributes: attributes)
        let assistString = NSMutableAttributedString(string: " / \(assist)", attributes: attributes)
        
        let deathAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemRed
        ]
        let deathString = NSMutableAttributedString(string: "\(death)", attributes: deathAttributes)
        
        killString.append(deathString)
        killString.append(assistString)
        self.attributedText = killString
    }
    
}
