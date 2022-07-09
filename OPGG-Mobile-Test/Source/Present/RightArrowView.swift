//
//  RightArrowView.swift
//  OPGG-Mobile-Test
//
//  Created by 진태우 on 2022/07/09.
//

import UIKit


final class RightArrowView: UIView {
    
    // MARK: UI
    
    private let imageView = UIImageView(image: UIImage(named: "iconArrowRight"))
    
    
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
        layer.cornerRadius = bounds.size.width * 0.5
    }
    
    
    // MARK: Setup
    
    private func setupAttributes() {
        backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        layer.masksToBounds = true
    }
    
    private func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
