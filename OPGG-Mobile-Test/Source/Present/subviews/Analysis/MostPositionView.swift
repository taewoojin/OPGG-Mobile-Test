//
//  MostPositionView.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/09.
//

import UIKit


final class MostPositionView: UIView {

    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [titleLabel, rateView])
    
    private let titleLabel = UILabel()
    
    private let rateView = WinningRateView()
    
    
    // MARK: Properties
    
//    private let game: Game
    
    
    // MARK: Initializing
    
    init() {
        super.init(frame: .zero)
        setupAttributes()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        containerStackView.axis = .vertical
        containerStackView.alignment = .center
        containerStackView.spacing = 8
        
        titleLabel.text = "포지션"
        titleLabel.font = .systemFont(ofSize: 10)
        titleLabel.textColor = #colorLiteral(red: 0.5960784314, green: 0.6274509804, blue: 0.6549019608, alpha: 1)
        
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configure(with analysis: AnalysedSummoner) {
        guard let position = analysis.mostPosition else { return }
        rateView.configure(image: position.positionType?.image, winningRate: position.winningRate)
    }
    
}
