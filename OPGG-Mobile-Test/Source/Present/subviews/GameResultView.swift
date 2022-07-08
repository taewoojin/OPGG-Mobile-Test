//
//  GameResultView.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit

final class GameResultView: UIView {

    // MARK: UI
    
    private lazy var stackView = UIStackView(arrangedSubviews: [resultLabel, separatorView, scoreLabel])
    
    private let resultLabel = UILabel()
    
    private let separatorView = UIView()
    
    private let scoreLabel = UILabel()
    
    
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
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 6
        
        resultLabel.textColor = .white
        resultLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        separatorView.backgroundColor = .white.withAlphaComponent(0.4)
        
        scoreLabel.textColor = .white
        scoreLabel.font = .systemFont(ofSize: 12)
    }
    
    private func setupLayout() {
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.trailing.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(1)
        }
    }
    
    private func configure() {
        backgroundColor = game.isWin ? .systemBlue : .systemRed
        resultLabel.text = game.isWin ? "승" : "패"
        scoreLabel.text = "1:1"
    }
    
}
