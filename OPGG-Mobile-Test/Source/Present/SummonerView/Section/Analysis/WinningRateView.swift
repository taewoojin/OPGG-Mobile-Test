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
        containerStackView.spacing = 4
        
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
    
    func configure(imageUrl: String, winningRate: Int) {
        imageView.loadImage(urlString: imageUrl, failedHandler:  { [weak self] error in
            if #available(iOS 13.0, *) {
                self?.imageView.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill")
            } else {
                // FIXME:
            }
        })
        rateLabel.text = "\(winningRate)%"
        rateLabel.textColor = winningRate == 100 ? #colorLiteral(red: 0.9098039216, green: 0.2509803922, blue: 0.3411764706, alpha: 1) : #colorLiteral(red: 0.1176470588, green: 0.1254901961, blue: 0.1333333333, alpha: 1)
    }
    
    func configure(image: UIImage?, winningRate: Int) {
        imageView.image = image
        rateLabel.text = "\(winningRate)%"
        rateLabel.textColor = winningRate == 100 ? #colorLiteral(red: 0.9098039216, green: 0.2509803922, blue: 0.3411764706, alpha: 1) : #colorLiteral(red: 0.1176470588, green: 0.1254901961, blue: 0.1333333333, alpha: 1)
    }
    
}
