//
//  TabCoordinator.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
        
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController

    var type: CoordinatorType { .tab }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        let pages: [TabBarPage] = [.media, .favorites].sorted(by: { $0.pageOrder < $1.pageOrder })
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.media.pageOrder
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.selectedImageTintColor = .systemPurple
        navigationController.viewControllers = [tabBarController]
    }
      
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationItem.largeTitleDisplayMode = .always
        navigationController.tabBarItem = .init(title: page.pageTitle, image: .init(systemName: page.image), tag: page.pageOrder)

        switch page {
        case .media:
            let mediaCoordinator = MediaCoordinator(navigationController)
            mediaCoordinator.finishDelegate = self
            mediaCoordinator.start()
            childCoordinators.append(mediaCoordinator)
        case .favorites:
            let favoritesCoordinator = FavoritesCoordinator(navigationController)
            favoritesCoordinator.finishDelegate = self
            favoritesCoordinator.start()
            childCoordinators.append(favoritesCoordinator)
        }
        
        return navigationController
    }
    
    func currentPage() -> TabBarPage? {
        return .init(index: tabBarController.selectedIndex)
    }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrder
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        tabBarController.selectedIndex = page.pageOrder
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
extension TabCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
    }
}
