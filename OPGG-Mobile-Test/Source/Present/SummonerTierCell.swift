//
//  SummonerTierCell.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit

import RxSwift


final class SummonerTierCell: UICollectionViewCell {
    
    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [
        tierImageView,
        contentStackView,
        arrowView
    ])
    
    private lazy var contentStackView = UIStackView(arrangedSubviews: [
        rankTypeLabel,
        tierLabel,
        lpLabel,
        winRateLabel
    ])
    
    private let tierImageView = UIImageView()
    
    private let rankTypeLabel = UILabel()
    
    private let tierLabel = UILabel()
    
    private let lpLabel = UILabel()
    
    private let winRateLabel = UILabel()
    
    private let arrowView = RightArrowView()
    
    
    // MARK: Properties
    
    private weak var viewModel: SummonerViewModel?
    
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
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        return layoutAttributes
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
        
        containerStackView.axis = .horizontal
        containerStackView.alignment = .center
        containerStackView.spacing = 8
        
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        contentStackView.spacing = 2
        
        tierImageView.layer.cornerRadius = 32
        tierImageView.layer.masksToBounds = true
        
        rankTypeLabel.textColor = #colorLiteral(red: 0.3254901961, green: 0.5137254902, blue: 0.9098039216, alpha: 1)
        rankTypeLabel.font = .systemFont(ofSize: 12)
        
        tierLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.1254901961, blue: 0.1333333333, alpha: 1)
        tierLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        lpLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.1254901961, blue: 0.1333333333, alpha: 1)
        lpLabel.font = .systemFont(ofSize: 12)
        
        winRateLabel.font = .systemFont(ofSize: 10)
        winRateLabel.textColor = #colorLiteral(red: 0.4823529412, green: 0.5215686275, blue: 0.5568627451, alpha: 1)
    }
    
    private func setupLayout() {
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(18)
        }
        
        tierImageView.snp.makeConstraints {
            $0.width.height.equalTo(64)
        }
        
        arrowView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
    }
    
    func configure(with league: League) {
        tierImageView.loadImage(urlString: league.tierRank.imageUrl)
        rankTypeLabel.text = league.tierRank.name
        tierLabel.text = league.tierRank.tier
        lpLabel.text = "\(league.tierRank.lp.withCommas()) LP"
        
        let winningRate = Int.winningRate(wins: league.wins, losses: league.losses)
        winRateLabel.text = "\(league.wins)승 \(league.losses)패 (\(winningRate)%)"
    }
    
}
