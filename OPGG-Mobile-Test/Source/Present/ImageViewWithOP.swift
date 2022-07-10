//
//  ImageViewWithOP.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/10.
//

import UIKit


final class ImageViewWithOP: UIView {
    
    // MARK: UI
    
    private let imageView = UIImageView()
    
    private let opBadgeLabel = PaddingLabel(top: 2, right: 4, bottom: 2, left: 4)
    
    
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
        
        opBadgeLabel.font = .systemFont(ofSize: 10, weight: .bold)
        opBadgeLabel.textColor = .white
        opBadgeLabel.layer.cornerRadius = 8
        opBadgeLabel.layer.borderWidth = 1
        opBadgeLabel.layer.borderColor = UIColor.white.cgColor
        opBadgeLabel.layer.masksToBounds = true
    }
    
    private func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(opBadgeLabel)
        opBadgeLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.bottom).inset(2)
            $0.centerX.equalToSuperview()
        }
    }
    
    func configure(imageUrl: String, opBadge: OPBadge?) {
        imageView.loadImage(urlString: imageUrl)
        opBadgeLabel.text = opBadge?.rawValue
        opBadgeLabel.backgroundColor = opBadge?.color
    }
}
