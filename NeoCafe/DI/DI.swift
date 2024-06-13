//
//  DI.swift
//  NeoCafe
//
//  Created by Pokerface on 04.06.2024.
//

import UIKit
import SwiftUI

final class Di {
    fileprivate let screenFactory: ScreenFactoryImpl
    fileprivate let coordinatorFactory: CoordinatorFactoryImpl
    
    
    init() {
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
    }
}

protocol AppFactory {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension Di: AppFactory {
    
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        let router = RouterImp(rootController: rootVC)
        let cooridnator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, cooridnator)
    }
    
}

protocol ScreenFactory {
    
    func makeMainScreen() -> UIViewController
    func makeMenuScreen() -> UIViewController
    func makeCartScreen() -> UIViewController
    func makeInfoScreen() -> UIViewController
    
}

final class ScreenFactoryImpl: ScreenFactory {
    func makeMainScreen() -> UIViewController {
        let vc = MainViewController()
        return vc
    }
    
    func makeMenuScreen() -> UIViewController {
        let vc = MenuViewController()
        return vc
    }
    
    func makeCartScreen() -> UIViewController {
        let vc = CartViewController()
        return vc
    }
    
    func makeInfoScreen() -> UIViewController {
        let vc = InfoViewController()
        return vc
    }
}

protocol CoordinatorFactory {
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator
    
    func makeTabBarCoordinator(router: Router) -> TabBarCoordinator
    func makeMainCoordinator(router: Router) -> MainCoordinator
    func makeMenuCoordinator(router: Router) -> MenuCoordinator
    func makeCartCoordinator(router: Router) -> CartCoordinator
    func makeInfoCoordinator(router: Router) -> InfoCoordinator
    
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
    
    
    private let screenFactory: ScreenFactory
    
    init(screenFactory: ScreenFactory){
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator {
        return ApplicationCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeTabBarCoordinator(router: Router) -> TabBarCoordinator {
        return TabBarCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeMainCoordinator(router: Router) -> MainCoordinator {
        return MainCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeMenuCoordinator(router: Router) -> MenuCoordinator {
        return MenuCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeCartCoordinator(router: Router) -> CartCoordinator {
        return CartCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeInfoCoordinator(router: Router) -> InfoCoordinator {
        return InfoCoordinator(router: router, screenFactory: screenFactory)
    }

}
