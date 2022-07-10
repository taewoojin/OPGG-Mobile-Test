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
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [
        thumbnailView,
        contentStackView
    ])
    
    private lazy var contentStackView = UIStackView(arrangedSubviews: [
        nameLabel,
        UIView(),
        refreshButton
    ])
    
    private let thumbnailView = ImageViewWithLevel()
    
    private let nameLabel = UILabel()
    
    private let refreshButton = UIButton()
    
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
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
        backgroundColor = .clear
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 20
        
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        
        nameLabel.textColor = .darkGray
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)

        refreshButton.setTitle("전적갱신", for: .normal)
        refreshButton.setTitleColor(.white, for: .normal)
        refreshButton.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.5137254902, blue: 0.9098039216, alpha: 1)
        refreshButton.layer.cornerRadius = 20
        refreshButton.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    private func setupLayout() {
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        thumbnailView.snp.makeConstraints {
            $0.width.height.equalTo(100)
        }
        
        refreshButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
    }
    
    private func setupBinding() {
        guard let viewModel = self.viewModel else { return }
        
        refreshButton.rx.tap
            .flatMap {
                Observable.merge(
                    .just(.fetchSummonerInfo),
                    .just(.fetchMatches)
                )
            }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
    }
    
    func configure(with summoner: Summoner, viewModel: SummonerViewModel?) {
        thumbnailView.configure(imageUrl: summoner.profileImageUrl, level: summoner.level)
        nameLabel.text = summoner.name
        
        self.viewModel = viewModel
        setupBinding()
    }
    
}
