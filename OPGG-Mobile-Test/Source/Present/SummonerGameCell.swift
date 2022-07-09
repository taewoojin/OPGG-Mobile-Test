//
//  SummonerGameCell.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit

import RxSwift


final class SummonerGameCell: UICollectionViewCell {
 
    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [resultView, contentStackView])

    private lazy var contentStackView = UIStackView(arrangedSubviews: [topInfoView, bottomInfoView])
    
    private var resultView: GameResultView!
    
    private var topInfoView: GameTopInfoView!
    
    private var bottomInfoView: GameBottomInfoView!
    
    
    // MARK: Properties
    
    private weak var viewModel: SummonerViewModel?
    
    private var disposeBag = DisposeBag()
    
    private var game: Game?
    
    
    // MARK: Life Cycle Views
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        backgroundColor = .white
        
        containerStackView.alignment = .center
        containerStackView.spacing = 16
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
    }
    
    private func setupLayout() {
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        resultView.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(100)
        }
    }
    
    func configure(with game: Game) {
        resultView = GameResultView(game: game)
        topInfoView = GameTopInfoView(game: game)
        bottomInfoView = GameBottomInfoView(game: game)
        
        setupAttributes()
        setupLayout()
    }
    
}
