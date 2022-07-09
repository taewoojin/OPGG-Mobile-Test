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


//enum Section: Hashable {
//    case info(content: [SectionItem])
////    case info
////    case seasonStats
////    case analysis
////    case game
//}

enum SectionType {
    case info
    case rankStats
    case analysis
    case game
}

enum SectionItem: Hashable {
    case info(Summoner)
    case rankStats([Int])
    case analysis
    case game(Game)
}

struct Section {
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
//        collectionViewLayout.scrollDirection = .horizontal
//        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
//        collectionViewLayout.headerReferenceSize = CGSize(width: collectionView.frame.size.width, height: 30)

        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.9764705882, alpha: 1)
//        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(SummonerInfoCell.self, forCellWithReuseIdentifier: SummonerInfoCell.typeName)
        collectionView.register(SummonerRankListCell.self, forCellWithReuseIdentifier: SummonerRankListCell.typeName)
        collectionView.register(SummonerAnalysisCell.self, forCellWithReuseIdentifier: SummonerAnalysisCell.typeName)
        collectionView.register(SummonerGameCell.self, forCellWithReuseIdentifier: SummonerGameCell.typeName)
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
            .map { .fetchGameInfo(1656750556) }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
    }
    
    override func setupBinding() {
//        collectionView.rx.setDataSource(self).disposed(by: disposeBag)
//        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.currentStore
            .map { store in
                return store.sections
            }
            .filterEmpty()
//            .take(1)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func setupDatasource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<Section> { dataSource, collectionView, indexPath, item in
            let section = dataSource.sectionModels[indexPath.section]
            
            switch section.type {
            case .info:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummonerInfoCell.typeName, for: indexPath) as! SummonerInfoCell
                if case let SectionItem.info(summoner) = item {
                    cell.configure(with: summoner)
                }
                return cell
                
            case .rankStats:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummonerRankListCell.typeName, for: indexPath) as! SummonerRankListCell
                cell.configure(viewModel: self.viewModel)
                return cell
                
            case .analysis:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummonerAnalysisCell.typeName, for: indexPath) as! SummonerAnalysisCell
                return cell
                
            case .game:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummonerGameCell.typeName, for: indexPath) as! SummonerGameCell
                if case let SectionItem.game(game) = item {
                    cell.configure(with: game)
                }
                return cell
                
            }
        }
    }

}


extension SummonerViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = dataSource.sectionModels[indexPath.section]

        switch section.type {
        case .info:
            return CGSize(width: collectionView.bounds.width, height: 100)
            
        case .rankStats:
            return CGSize(width: collectionView.bounds.width, height: 100)
            
        case .analysis:
            return CGSize(width: collectionView.bounds.width, height: 90)
            
        case .game:
            return CGSize(width: collectionView.bounds.width, height: 100)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let type = dataSource.sectionModels[section].type
        
        switch type {
        case .info: return UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        case .rankStats: return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        case .analysis: return UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        case .game: return UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        }
    }
}
