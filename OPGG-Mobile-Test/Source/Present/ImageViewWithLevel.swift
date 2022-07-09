//
//  ImageViewWithLevel.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/09.
//

import UIKit


final class ImageViewWithLevel: UIView {
    
    // MARK: UI
    
    private let imageView = UIImageView()
    
    private let levelLabel = PaddingLabel(top: 5, right: 8, bottom: 5, left: 8)
    
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = bounds.size.width * 0.5
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        imageView.layer.masksToBounds = true
        
        levelLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        levelLabel.font = .systemFont(ofSize: 12)
        levelLabel.textColor = .white
        levelLabel.layer.cornerRadius = 12
        levelLabel.layer.masksToBounds = true
    }
    
    private func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(levelLabel)
        levelLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(imageUrl: String, level: Int) {
        imageView.loadImage(urlString: imageUrl)
        levelLabel.text = "\(level)"
    }
}
