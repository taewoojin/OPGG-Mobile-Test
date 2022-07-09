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
    
    
    // MARK: Properties
    
    private let game: Game
    
    
    // MARK: Initializing
    
    init(game: Game) {
        self.game = game
        super.init(frame: .zero)
        setupAttributes()
        setupLayout()
        configure()
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
    
    private func configure() {
        typeLabel.text = game.gameType
        timeLabel.text = "2분 전"
    }
    
}