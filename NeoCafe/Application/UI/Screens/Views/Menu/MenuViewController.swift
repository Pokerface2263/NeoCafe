//
//  MenuViewController.swift
//  NeoCafe
//
//  Created by Pokerface on 06.06.2024.
//

import UIKit

class MenuViewController: UIViewController {
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Menu View Controller"
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        label.textColor = Constants.Color.orangColor
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        
        setupUI()
    }
}

//MARK: - Setup views and constraints methods
private extension MenuViewController {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(textLabel)
    }
    
    func setupConstraints() {
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
