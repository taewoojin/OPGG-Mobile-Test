//
//  SeasonStatesCell.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit

import RxSwift


final class SeasonStatesCell: UICollectionViewCell {
    
    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [thumbnailView, contentStackView])
    
    private lazy var contentStackView = UIStackView(arrangedSubviews: [rankTypeLabel, nameLabel])
    
    private let thumbnailView = UIImageView()
    
    private let rankTypeLabel = UILabel()
    
    private let nameLabel = UILabel()
    
    
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
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        backgroundColor = .white
        contentView.layer.cornerRadius = 4
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 20
        
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        
        thumbnailView.backgroundColor = .systemBlue
        thumbnailView.layer.cornerRadius = 25
        thumbnailView.layer.masksToBounds = true
        
        rankTypeLabel.text = "soloRank"
        rankTypeLabel.textColor = .systemBlue
        
        nameLabel.text = "Grandmaster"
        nameLabel.textColor = .darkGray
        nameLabel.font = .systemFont(ofSize: 15)
    }
    
    private func setupLayout() {
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        thumbnailView.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
    }
    
    private func setupBinding() {

    }
    
    func configure(with summoner: Summoner) {
        nameLabel.text = summoner.name
    }
    
    
}
