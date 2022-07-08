//
//  SummonerRankListCell.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit

import RxSwift


final class SummonerRankListCell: UICollectionViewCell {
    
    // MARK: UI
    
    private let collectionViewLayout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    
    // MARK: Properties
    
    private weak var viewModel: SummonerViewModel?
    
    private var disposeBag = DisposeBag()
    
    private let items = [1,2,3,4,5,6,7,8,9,10]
    
    
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
        backgroundColor = .clear
        
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.register(SeasonStatesCell.self, forCellWithReuseIdentifier: SeasonStatesCell.typeName)
    }
    
    private func setupLayout() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.height.equalTo(100)
        }
    }
    
    private func setupBinding() {
        disposeBag = DisposeBag()
        
        Observable.just(items)
            .bind(to: collectionView.rx.items(cellIdentifier: SeasonStatesCell.typeName, cellType: SeasonStatesCell.self)) { row, element, cell in
                print("row:", row)
            }
            .disposed(by: disposeBag)
    }
    
    func configure(viewModel: SummonerViewModel?) {
        self.viewModel = viewModel
        
        setupBinding()
    }
    
}

extension SummonerRankListCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * (2/3), height: 100)
    }
    
}
