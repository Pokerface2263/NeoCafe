//
//  MainCoordinator.swift
//  NeoCafe
//
//  Created by Pokerface on 04.06.2024.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
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
//        let viewModel = MainViewModel()
//        viewModel.onSelectProduct = { [weak self] id in
//            DispatchQueue.main.async {
//                self?.openDetails(id: id, mainViewModel: viewModel)
//            }
//        }
        let mainScreen = screenFactory.makeMainScreen()
        router.setRootModule(mainScreen, hideBar: true)
    }
    
//    private func openDetails(id: UUID, mainViewModel: MainViewModel) {
//        let viewModel = DetailViewModel(id: id)
//        viewModel.dismissed = { [weak self] in
//            self?.router.dismissModule()
//            mainViewModel.loadProducts()
//        }
//        let detailView = screenFactory.makeDetailScreen(viewModel: viewModel)
//        DispatchQueue.main.async { [weak self] in
//            self?.router.present(detailView, animated: true)
//        }
//    }
}
