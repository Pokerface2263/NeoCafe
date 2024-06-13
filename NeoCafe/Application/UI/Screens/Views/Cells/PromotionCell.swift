//
//  PromotionCell.swift
//  NeoCafe
//
//  Created by Pokerface on 05.06.2024.
//

import UIKit

class PromotionCell: UICollectionViewCell {
    static let reuseIdentifier = "PromotionCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        return imageView
    }()
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with promotion: Promotion, indexPath: Int) {
        Task {
            if let image = await APICaller.loadImage(imageURL: promotion.imageURL) {
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
            }
        }
        titleLabel.text = promotion.title
        if indexPath == 0 {
            titleLabel.textColor = .systemBrown
        }
    }
}

//MARK: - Setup views and constraints methods
private extension PromotionCell {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor(red: 225/255, green: 223/255, blue: 221/255, alpha: 1)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.Values.mediumOffset)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.centerY.equalToSuperview()
        }
    }
}
