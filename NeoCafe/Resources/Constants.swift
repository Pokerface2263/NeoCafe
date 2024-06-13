//
//  Constants.swift
//  NeoCafe
//
//  Created by Pokerface on 05.06.2024.
//

import UIKit

struct Constants {
    
    struct Color {
        static let orangColor = UIColor(red: 231/255, green: 88/255, blue: 44/255, alpha: 1)
        static let lightGrey = UIColor(red: 242/255, green: 244/255, blue: 249/255, alpha: 1)
        static let gray = UIColor(red: 165/255, green: 178/255, blue: 186/255, alpha: 1)
        static let black = UIColor(red: 34/255, green: 16/255, blue: 11/255, alpha: 1)
    }
    
    struct Values {
        static let  mainScreen = UIScreen.main.bounds
        
        static let smallOffset = mainScreen.width * 0.015
        static let mediumOffset = mainScreen.width * 0.04
        static let bigOffset = mainScreen.width * 0.08
        static let largeOffset = mainScreen.width * 1
    }
}
