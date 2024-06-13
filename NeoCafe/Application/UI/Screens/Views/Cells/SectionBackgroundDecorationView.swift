//
//  SectionBackgroundDecorationView.swift
//  NeoCafe
//
//  Created by Pokerface on 05.06.2024.
//

import UIKit

class SectionBackgroundDecorationView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.Color.lightGrey
        self.layer.cornerRadius = 24
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

    }
}

