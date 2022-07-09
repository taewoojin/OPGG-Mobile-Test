//
//  WinningRateView.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/09.
//

import UIKit


final class WinningRateView: UIView {

    // MARK: UI
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [imageView, rateLabel])
    
    private let imageView = UIImageView()
    
    private let rateLabel = UILabel()
    
    
    // MARK: Properties
    
    private let imageHeight: CGFloat = 30
    
    
    // MARK: Initializing
    
    init() {
        super.init(frame: .zero)
        setupAttributes()
        setupLayout()
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        containerStackView.axis = .vertical
        containerStackView.alignment = .center
        containerStackView.spacing = 4
        
        imageView.backgroundColor = .systemRed
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageHeight / 2
        
        rateLabel.font = .systemFont(ofSize: 10)
        rateLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.1254901961, blue: 0.1333333333, alpha: 1)
        rateLabel.textAlignment = .center
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(imageHeight)
        }
    }
    
    private func configure() {
//        imageView.loadImage(urlString: )
        rateLabel.text = "100%"

        // TODO: rateLabel 색상 처리
    }
    
}
