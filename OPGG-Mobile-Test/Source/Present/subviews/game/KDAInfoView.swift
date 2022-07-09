//
//  KDAInfoView.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/08.
//

import UIKit


final class KDAInfoView: UIView {

    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [kdaLabel, contributionForKillRateLabel])
    
    private let kdaLabel = UILabel()
    
    private let contributionForKillRateLabel = UILabel()
    
    
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
        containerStackView.alignment = .leading
        containerStackView.spacing = 2
        
        kdaLabel.textColor = .black
        kdaLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        contributionForKillRateLabel.textColor = .systemGray
        contributionForKillRateLabel.font = .systemFont(ofSize: 12)
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with game: Game) {
        let kill = game.stats.general.kill
        let death = game.stats.general.death
        let assist = game.stats.general.assist
        kdaLabel.text = "\(kill) / \(death) / \(assist)"
        
        contributionForKillRateLabel.text = "킬관여 \(game.stats.general.contributionForKillRate)"
    }
    
}
