//
//  SummonerAnalysisCell.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit

import RxSwift


final class SummonerAnalysisCell: UICollectionViewCell {
 
    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [
        recentGameAnalysisView,
        UIView(),
        mostWinningView,
        mostPositionView
    ])
    
    private let recentGameAnalysisView = RecentGameAnalysisView()
    
    private let mostWinningView = MostWinningView()
    
    private let mostPositionView = MostPositionView()
    
    
    // MARK: Properties
    
    private var disposeBag = DisposeBag()
    
    
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
    
    
    // MARK: Life Cycle Views
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        backgroundColor = .white
        
    }
    
    private func setupLayout() {
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
    }
    
}
