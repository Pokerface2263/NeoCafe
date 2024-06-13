//
//  TabBarCoordinator.swift
//  NeoCafe
//
//  Created by Pokerface on 06.06.2024.
//

import UIKit

final class TabBarCoordinator: BaseCoordinator {
    
    var finishFlow: (() -> ())?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    private let tabBarController: UITabBarController

    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
        self.tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = Constants.Color.orangColor
    }
    
    override func start() {
        
        let firstNavigationController = UINavigationController()
        let secondNavigationController = UINavigationController()
        let thirdNavigationController = UINavigationController()
        let fourthNavigationController = UINavigationController()
        
        firstNavigationController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "unselectedHome"), selectedImage: UIImage(named: "selectedHome"))
        secondNavigationController.tabBarItem = UITabBarItem(title: "Меню", image: UIImage(named: "unselectedBowl"), selectedImage: UIImage(named: "selectedBowl"))
        thirdNavigationController.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "unselectedBag"), selectedImage: UIImage(named: "selectedBag"))
        fourthNavigationController.tabBarItem = UITabBarItem(title: "Инфо", image: UIImage(named: "unselectedInfo"), selectedImage: UIImage(named: "selectedInfo"))
        
        let mainCoordinator = MainCoordinator(router: RouterImp(rootController: firstNavigationController), screenFactory: screenFactory)
        self.addDependency(mainCoordinator)
        mainCoordinator.start()
        
        let menuCoordinator = MenuCoordinator(router: RouterImp(rootController: secondNavigationController), screenFactory: screenFactory)
        self.addDependency(menuCoordinator)
        menuCoordinator.start()
        
        let cartCoordinator = CartCoordinator(router: RouterImp(rootController: thirdNavigationController), screenFactory: screenFactory)
        self.addDependency(cartCoordinator)
        cartCoordinator.start()
        
        let infoCoordinator = InfoCoordinator(router: RouterImp(rootController: fourthNavigationController), screenFactory: screenFactory)
        self.addDependency(infoCoordinator)
        infoCoordinator.start()
        
        
        tabBarController.viewControllers = [firstNavigationController, secondNavigationController, thirdNavigationController, fourthNavigationController]
        
        router.setRootModule(tabBarController, hideBar: true)
    }
}
