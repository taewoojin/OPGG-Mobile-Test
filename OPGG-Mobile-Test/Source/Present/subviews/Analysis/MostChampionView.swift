//
//  MostChampionView.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/09.
//

import UIKit


final class MostChampionView: UIView {

    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [titleLabel, contentStackView])
    
    private let contentStackView = UIStackView()
    
    private let titleLabel = UILabel()
    
    
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
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        containerStackView.axis = .vertical
        containerStackView.alignment = .center
        containerStackView.spacing = 8
        
        contentStackView.alignment = .center
        contentStackView.spacing = 16
        
        titleLabel.text = "모스트 승률"
        titleLabel.font = .systemFont(ofSize: 10)
        titleLabel.textColor = #colorLiteral(red: 0.5960784314, green: 0.6274509804, blue: 0.6549019608, alpha: 1)
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(11)
        }
    }
    
    func configure(with analysis: AnalysedSummoner) {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for champion in analysis.mostChampions {
            let view = WinningRateView()
            view.configure(imageUrl: champion.imageUrl, winningRate: champion.winningRate)
            contentStackView.addArrangedSubview(view)
        }
    }
    
}
