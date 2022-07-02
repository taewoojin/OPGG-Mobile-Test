//
//  ViewController.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/02.
//

import UIKit


class SummonerViewController: BaseViewController {

    
    
    // MARK: Properties
    
    let viewModel: SummonerViewModel
    
    
    // MARK: Initializing
    
    init(viewModel: SummonerViewModel = SummonerViewModel()) {
        self.viewModel = viewModel
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setup
    
    override func setupLifeCycleBinding() {
        rx.viewDidLoad
            .map { .fetchSummonerInfo }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
        
        rx.viewDidLoad
            .map { .fetchGameInfo(1656750556) }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
    }

}

