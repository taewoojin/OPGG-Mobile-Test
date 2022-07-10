//
//  GameTimeView.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit


final class GameTimeView: UIView {

    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [typeLabel, timeLabel])
    
    private let typeLabel = UILabel()
    
    private let timeLabel = UILabel()
    
    
    // MARK: Initializing
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttributes()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        containerStackView.axis = .vertical
        containerStackView.alignment = .trailing
        containerStackView.spacing = 1
        
        typeLabel.textColor = .systemGray
        typeLabel.font = .systemFont(ofSize: 12)
        
        timeLabel.textColor = .systemGray
        timeLabel.font = .systemFont(ofSize: 12)
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with game: Game) {
        typeLabel.text = game.gameType
        
        let date = Date(timeIntervalSince1970: game.createDate)
        timeLabel.text = calcElapsedTime(from: date)
    }
    
    private func calcElapsedTime(from date: Date) -> String {
        // TODO:
        let diffDate = Calendar.current.dateComponents([.second, .minute, .hour, .day, .weekOfMonth], from: date, to: Date())
        
        if diffDate.weekOfMonth! > 0 {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter.string(from: date)
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
