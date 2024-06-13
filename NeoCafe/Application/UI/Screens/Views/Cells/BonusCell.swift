//
//  BonusCell.swift
//  NeoCafe
//
//  Created by Pokerface on 05.06.2024.
//

import UIKit
import SnapKit

class BonusCell: UICollectionViewCell {
    static let reuseIdentifier = "BonusCell"
    
    private var backgoundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coin")
        return imageView
    }()
    
    private let textView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let bonusLabel: UILabel = {
       let label = UILabel()
        label.text = "Бонусная карта"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let bonusCountLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .white
        return label
    }()
    
    private let qrBackgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private var qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "qr")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with bonusPoints: Int) {
        bonusCountLabel.text = "\(bonusPoints) Б̅"
    }
}

//MARK: - Setup views and constraints methods
private extension BonusCell {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor(red: 231/255, green: 88/255, blue: 44/255, alpha: 1)
        
        contentView.addSubview(backgoundImageView)
        
        contentView.addSubview(textView)
        textView.addSubview(bonusLabel)
        textView.addSubview(bonusCountLabel)
        
        contentView.addSubview(qrBackgroundView)
        qrBackgroundView.addSubview(qrImageView)
    }
    
    func setupConstraints() {
        backgoundImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        textView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.6)
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.77)
        }
        bonusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        bonusCountLabel.snp.makeConstraints { make in
            make.top.equalTo(bonusLabel.snp.bottom)
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
        
        qrBackgroundView.snp.makeConstraints { make in
            make.leading.equalTo(textView.snp.trailing).offset(10)
            make.height.width.equalTo(contentView.snp.height).multipliedBy(0.6)
            make.centerY.equalToSuperview()
        }
        qrImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.7)
        }
    }
}
