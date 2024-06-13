//
//  PopularProductCell.swift
//  NeoCafe
//
//  Created by Pokerface on 05.06.2024.
//

import UIKit
import SnapKit

class PopularProductCell: UICollectionViewCell {
    static let reuseIdentifier = "PopularProductCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = Constants.Color.orangColor
        return label
    }()
    private let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Color.orangColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        
        Task {
            if let image = await APICaller.loadImage(imageURL: product.imageURL) {
                DispatchQueue.main.async { [weak self] in
                    self?.productImageView.image = image
                }
            }
        }
        nameLabel.text = product.title
        priceLabel.text = "\(product.price) с"
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addButton)
        
        productImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(Constants.Values.smallOffset)
            make.height.equalToSuperview().multipliedBy(0.45)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(Constants.Values.smallOffset)
            make.leading.trailing.equalToSuperview().inset(Constants.Values.smallOffset)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.Values.mediumOffset)
            make.leading.equalToSuperview().inset(Constants.Values.smallOffset)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(Constants.Values.smallOffset)
            make.leading.trailing.bottom.equalToSuperview().inset(Constants.Values.smallOffset)
        }
    }
}
