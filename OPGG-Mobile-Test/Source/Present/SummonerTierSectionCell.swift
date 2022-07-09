//
//  SummonerTierSectionCell.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit

import RxSwift


final class SummonerTierSectionCell: UICollectionViewCell {
    
    // MARK: UI
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(SummonerTierCell.self, forCellWithReuseIdentifier: SummonerTierCell.typeName)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private func setupLayout() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        disposeBag = DisposeBag()
        
        viewModel?.currentStore
            .map { $0.summonerInfo?.leagues }
            .filterNil()
            .bind(to: collectionView.rx.items(cellIdentifier: SummonerTierCell.typeName, cellType: SummonerTierCell.self)) { row, element, cell in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
    }
    
    func configure(viewModel: SummonerViewModel?) {
        self.viewModel = viewModel
        setupBinding()
    }
    
}

extension SummonerTierSectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 272, height: 100)
    }
    
}
