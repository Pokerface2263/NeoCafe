//
//  CartCoordinator.swift
//  NeoCafe
//
//  Created by Pokerface on 06.06.2024.
//

import UIKit

final class CartCoordinator: BaseCoordinator {
    
    var finishFlow: (() -> ())?
    
    private let router: Router
    private let screenFactory: ScreenFactory
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        showMain()
    }
    
    private func showMain() {
        let cartScreen = screenFactory.makeCartScreen()
        router.setRootModule(cartScreen, hideBar: true)
    }
    
}
