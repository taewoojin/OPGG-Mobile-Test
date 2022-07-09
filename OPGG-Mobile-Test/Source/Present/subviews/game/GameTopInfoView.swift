//
//  GameTopInfoView.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit


final class GameTopInfoView: UIView {

    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [
        charactorImageView,
        traitsStackView,
        kdaInfoView
    ])
    
    private let charactorImageView = UIImageView()
    
    private lazy var traitsStackView = UIStackView(arrangedSubviews: [spellStackView, peakStackView])
    
    private let spellStackView = UIStackView()
    
    private let peakStackView = UIStackView()
    
    private let kdaInfoView = KDAInfoView()
    
    private let gameTimeView = GameTimeView()
    
    
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
        containerStackView.alignment = .center
        containerStackView.spacing = 4
        
        traitsStackView.spacing = 2
        
        spellStackView.axis = .vertical
        spellStackView.spacing = 2
        
        peakStackView.axis = .vertical
        peakStackView.spacing = 2
        
        charactorImageView.backgroundColor = .systemGray
        charactorImageView.contentMode = .scaleAspectFill
        charactorImageView.layer.masksToBounds = true
        charactorImageView.layer.cornerRadius = 20
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        
        addSubview(gameTimeView)
        gameTimeView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(containerStackView.snp.trailing).inset(14)
            $0.top.trailing.equalToSuperview()
        }
        
        charactorImageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
    }
    
    func configure(with game: Game) {
        kdaInfoView.configure(with: game)
        gameTimeView.configure(with: game)
        
        charactorImageView.loadImage(urlString: game.champion.imageUrl)
        
        spellStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for spell in game.spells {
            let imageView = UIImageView()
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 3
            imageView.snp.makeConstraints { $0.width.height.equalTo(19) }
            imageView.loadImage(urlString: spell.imageUrl)
            spellStackView.addArrangedSubview(imageView)
        }
        
        peakStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for peak in game.peak {
            let imageView = UIImageView()
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 10
            imageView.snp.makeConstraints { $0.width.height.equalTo(19) }
            imageView.loadImage(urlString: peak)
            peakStackView.addArrangedSubview(imageView)
        }
        
    }
    
}
