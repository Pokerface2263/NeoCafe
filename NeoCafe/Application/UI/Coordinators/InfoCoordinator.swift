//
//  InfoCoordinator.swift
//  NeoCafe
//
//  Created by Pokerface on 06.06.2024.
//

import UIKit

final class InfoCoordinator: BaseCoordinator {
    
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
        let infoScreen = screenFactory.makeInfoScreen()
        router.setRootModule(infoScreen, hideBar: true)
    }
}
