//
//  ViewController.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//

import UIKit

import RxDataSources
import RxOptional
import RxSwift
import SnapKit


enum SectionType {
    case info
    case rankStats
    case analysis
    case game
}

enum SectionItem: Hashable {
    case info(Summoner)
    case rankStats([Int])
    case analysis(AnalysedSummoner)
    case game(Game)
}

struct Section: Hashable {
    var type: SectionType
    var items: [SectionItem]
}


extension Section: SectionModelType {
    
    typealias Item = SectionItem
    
    init(original: Section, items: [Item]) {
        self = original
        self.items = items
    }
}



final class SummonerViewController: BaseViewController {
    
    // MARK: UI
    
    private let collectionViewLayout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    )
    
    
    // MARK: Properties
    
    private let viewModel: SummonerViewModel
    
    private var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    
    // MARK: Initializing
    
    init(viewModel: SummonerViewModel = SummonerViewModel()) {
        self.viewModel = viewModel
        super.init()
        setupDatasource()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setup
    
    override func setupAttributes() {
        super.setupAttributes()
        
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        collectionView.register(
            SummonerInfoCell.self,
            forCellWithReuseIdentifier: SummonerInfoCell.typeName
        )
        collectionView.register(
            SummonerTierSectionCell.self,
            forCellWithReuseIdentifier: SummonerTierSectionCell.typeName
        )
        collectionView.register(
            SummonerAnalysisCell.self,
            forCellWithReuseIdentifier: SummonerAnalysisCell.typeName
        )
        collectionView.register(
            SummonerGameCell.self,
            forCellWithReuseIdentifier: SummonerGameCell.typeName
        )
    }
    
    override func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupLifeCycleBinding() {
        let viewDidLoad = rx.viewDidLoad.share(replay: 1, scope: .whileConnected)
        
        viewDidLoad
            .map { .fetchSummonerInfo }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
        
        viewDidLoad
            .map { .fetchMatches }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
    }
    
    override func setupBinding() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        collectionView.rx.willDisplayCell
            .filter { [unowned self] (_, indexPath) in
                let gamesCount = self.viewModel.store.games.count
                if gamesCount < 20 {
                    return false
                }
                
                return gamesCount - 2 == indexPath.item
            }
            .map { [weak self] _ in self?.viewModel.store.games.last?.createDate }
            .filterNil()
            .map { .fetchMoreMatches($0) }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
        
        viewModel.currentStore
            .map { $0.sections }
            .filterEmpty()
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func setupDatasource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<Section> {
            dataSource, collectionView, indexPath, item in
            
            switch item {
            case let .info(summoner):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SummonerInfoCell.typeName,
                    for: indexPath
                ) as! SummonerInfoCell
                cell.configure(with: summoner, viewModel: self.viewModel)
                return cell
                
            case .rankStats(_):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SummonerTierSectionCell.typeName,
                    for: indexPath
                ) as! SummonerTierSectionCell
                cell.configure(viewModel: self.viewModel)
                return cell
                
            case .analysis:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SummonerAnalysisCell.typeName,
                    for: indexPath
                ) as! SummonerAnalysisCell
                return cell
                
            case let .game(game):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SummonerGameCell.typeName,
                    for: indexPath
                ) as! SummonerGameCell
                cell.configure(with: game)
                return cell
            }
            
        }
    }

}


// MARK: - UICollectionViewDelegateFlowLayout

extension SummonerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let type = dataSource.sectionModels[indexPath.section].type
        switch type {
        case .info: return CGSize(width: collectionView.bounds.width - (24 * 2), height: 100)
        case .rankStats: return CGSize(width: collectionView.bounds.width, height: 120)
        default: return CGSize(width: collectionView.bounds.width, height: 100)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let type = dataSource.sectionModels[section].type
        
        switch type {
        case .info: return UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        case .rankStats: return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .analysis: return UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        case .game: return UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        }
    }
}
