//
//  SummonerInfoCell.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/07.
//

import UIKit

import RxSwift


final class SummonerInfoCell: UICollectionViewCell {
    
    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [thumbnailView, contentStackView])
    
    private lazy var contentStackView = UIStackView(arrangedSubviews: [nameLabel, refreshButton])
    
    private let thumbnailView = UIImageView()
    
    private let nameLabel = UILabel()
    
    private let refreshButton = UIButton()
    
    private let collectionViewLayout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    
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
        backgroundColor = .clear
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 20
        
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillProportionally
        contentStackView.alignment = .leading
        
        thumbnailView.backgroundColor = .systemBlue
        thumbnailView.layer.cornerRadius = 50
        thumbnailView.layer.masksToBounds = true
        
        nameLabel.text = "OPGG"
        nameLabel.textColor = .darkGray
        nameLabel.font = .systemFont(ofSize: 15)
        
//        var configuration = UIButton.Configuration.plain()
//        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30)
//        refreshButton.configuration = configuration
        refreshButton.setTitle("전적갱신", for: .normal)
        refreshButton.setTitleColor(.white, for: .normal)
        refreshButton.backgroundColor = .systemBlue
        refreshButton.layer.cornerRadius = 20
//        refreshButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        
        
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.register(SeasonStatesCell.self, forCellWithReuseIdentifier: SeasonStatesCell.typeName)
    }
    
    private func setupLayout() {
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        thumbnailView.snp.makeConstraints {
            $0.width.height.equalTo(100)
        }
        
        refreshButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupBinding() {
    }
    
    func configure(with summoner: Summoner) {
        nameLabel.text = summoner.name
    }
    
    
}
