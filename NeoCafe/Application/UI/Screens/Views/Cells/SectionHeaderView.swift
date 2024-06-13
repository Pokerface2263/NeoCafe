//
//  SectionHeaderView.swift
//  NeoCafe
//
//  Created by Pokerface on 05.06.2024.
//

import UIKit
import SnapKit

class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
    
    var allButtonHandler: (() -> ())?
    
    private let wholeView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Constants.Color.black
        return label
    }()
    
    private lazy var allButton: UIButton = {
        let button = UIButton()
        button.setTitle("Все", for: .normal)
        button.setTitleColor(Constants.Color.gray, for: .normal)
        button.addTarget(self, action: #selector(allButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, buttonHandler: @escaping () -> ()) {
        titleLabel.text = title
        allButtonHandler = buttonHandler
    }
}

//MARK: - Private methods
private extension SectionHeaderView {
    
    @objc
    func allButtonPressed() {
        allButtonHandler?()
    }
}

//MARK: - Setup views and constraints methods
private extension SectionHeaderView {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(wholeView)
        wholeView.addSubview(titleLabel)
        wholeView.addSubview(allButton)
    }
    
    func setupConstraints() {
        wholeView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Values.bigOffset)
            make.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        allButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
