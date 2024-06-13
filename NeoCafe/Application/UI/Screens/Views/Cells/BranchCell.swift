//
//  BranchCell.swift
//  NeoCafe
//
//  Created by Pokerface on 05.06.2024.
//

import UIKit

class BranchCell: UICollectionViewCell {
    static let reuseIdentifier = "BranchCell"
    
    private lazy var  branchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let textView = UIView()
    
    private lazy var  nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = Constants.Color.black
        return label
    }()
    
    private lazy var  addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = Constants.Color.gray
        return label
    }()
    
    private let workingHourView = UIView()
    
    private lazy var clockImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "clock")
        return imageView
    }()
    
    private lazy var  workingHoursLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = Constants.Color.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with branch: Branch) {
        Task {
            if let image = await APICaller.loadImage(imageURL: branch.imageURL) {
                DispatchQueue.main.async { [weak self] in
                    self?.branchImageView.image = image
                }
            }
        }
        nameLabel.text = branch.title
        addressLabel.text = branch.address
        workingHoursLabel.text = "\(branch.startTime)-\(branch.endTime)"
    }
    
    private func setupViews() {
        contentView.addSubview(branchImageView)
        contentView.addSubview(textView)
        textView.addSubview(nameLabel)
        textView.addSubview(addressLabel)
        textView.addSubview(workingHourView)
        workingHourView.addSubview(clockImageView)
        workingHourView.addSubview(workingHoursLabel)
        
        branchImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(Constants.Values.smallOffset)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        textView.snp.makeConstraints { make in
            make.leading.equalTo(branchImageView.snp.trailing)
            make.top.trailing.bottom.equalToSuperview().inset(Constants.Values.mediumOffset)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(Constants.Values.smallOffset)
        }
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.Values.smallOffset)
            make.leading.equalToSuperview().inset(Constants.Values.smallOffset)
        }
        workingHourView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(Constants.Values.smallOffset)
        }
        clockImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        workingHoursLabel.snp.makeConstraints { make in
            make.leading.equalTo(clockImageView.snp.trailing).offset(Constants.Values.smallOffset)
            make.centerY.equalToSuperview()
        }
    }
}
