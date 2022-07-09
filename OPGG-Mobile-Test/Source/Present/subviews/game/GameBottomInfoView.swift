//
//  GameBottomInfoView.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit


final class GameBottomInfoView: UIView {

    // MARK: UI
    
    private lazy var itemStackView = UIStackView()
    
    private let largestMultiKillLabel = PaddingLabel(top: 4, right: 8, bottom: 3, left: 8)
    
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
        itemStackView.axis = .horizontal
        itemStackView.spacing = 2
        
        largestMultiKillLabel.font = .systemFont(ofSize: 10)
        largestMultiKillLabel.textColor = #colorLiteral(red: 0.9098039216, green: 0.2509803922, blue: 0.3411764706, alpha: 1)
        largestMultiKillLabel.layer.masksToBounds = true
        largestMultiKillLabel.layer.cornerRadius = 9
        largestMultiKillLabel.layer.borderWidth = 1
        largestMultiKillLabel.layer.borderColor = UIColor.systemRed.cgColor
    }
    
    private func setupLayout() {
        addSubview(itemStackView)
        itemStackView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        
        addSubview(largestMultiKillLabel)
        largestMultiKillLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(itemStackView.snp.trailing)
            $0.trailing.centerY.equalToSuperview()
        }
    }
    
    private func configure() {
        for item in game.items {
            let imageView = UIImageView()
            imageView.backgroundColor = .systemGray
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 3
            imageView.snp.makeConstraints { $0.width.height.equalTo(24) }
            imageView.loadImage(urlString: item.imageUrl)
            itemStackView.addArrangedSubview(imageView)
        }
        
        largestMultiKillLabel.text = game.stats.general.largestMultiKillString
        largestMultiKillLabel.isHidden = game.stats.general.largestMultiKillString.isEmpty
    }
    
}
