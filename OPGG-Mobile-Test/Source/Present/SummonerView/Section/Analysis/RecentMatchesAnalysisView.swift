//
//  RecentMatchesAnalysisView.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/09.
//

import UIKit


final class RecentMatchesAnalysisView: UIView {

    // MARK: UI
    
    private lazy var contentStackView = UIStackView(arrangedSubviews: [
        winLoseLabel,
        scoreLabel,
        kdaStackView
    ])
    
    private let titleLabel = UILabel()
    
    private let winLoseLabel = UILabel()
    
    private let scoreLabel = ScoreLabel()
    
    private lazy var kdaStackView = UIStackView(arrangedSubviews: [kdaLabel, winningRateLabel])
    
    private let kdaLabel = UILabel()
    
    private let winningRateLabel = UILabel()
    
    
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
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        contentStackView.spacing = 2
        
        titleLabel.text = "최근 20게임 분석"
        titleLabel.font = .systemFont(ofSize: 10)
        titleLabel.textColor = #colorLiteral(red: 0.5960784314, green: 0.6274509804, blue: 0.6549019608, alpha: 1)
        
        winLoseLabel.textColor = #colorLiteral(red: 0.5960784314, green: 0.6274509804, blue: 0.6549019608, alpha: 1)
        winLoseLabel.font = .systemFont(ofSize: 10)
        
        scoreLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        kdaLabel.textColor = #colorLiteral(red: 0.03921568627, green: 0.7725490196, blue: 0.5568627451, alpha: 1)
        kdaLabel.font = .systemFont(ofSize: 10)
        
        winningRateLabel.textColor = #colorLiteral(red: 0.9098039216, green: 0.2509803922, blue: 0.3411764706, alpha: 1)
        winningRateLabel.font = .systemFont(ofSize: 10)
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(with analysis: AnalysedSummoner) {
        winLoseLabel.text = "\(analysis.summary.wins)승 \(analysis.summary.losses)패"
        scoreLabel.configure(
            kill: analysis.averageKills,
            death: analysis.averageDeaths,
            assist: analysis.averageAssists
        )
        kdaLabel.text = "\(analysis.kda):1"
        winningRateLabel.text = "(\(analysis.winningRate)%)"
    }
    
}
