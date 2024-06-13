//
//  AppCoordinator.swift
//  NeoCafe
//
//  Created by Pokerface on 04.06.2024.
//


import UIKit

final class ApplicationCoordinator: BaseCoordinator {
        
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runMainFlow()
    }
    
    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeTabBarCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
