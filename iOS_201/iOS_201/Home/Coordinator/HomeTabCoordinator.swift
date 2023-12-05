//
//  HomeTabCoordinator.swift
//  iOS_201
//
//  Created by Hyeonho on 11/30/23.
//

import Foundation
import UIKit

class HomeTabCoordinator: TabCoordinator {
    var delegate: AppCoordinator?
    var tabBarItem: UITabBarItem?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        vc.tabBarItem = self.tabBarItem
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func finish() {}
    
    func goToFeedView() {
        let coordinator = FeedCoordinator(childCoordinators: childCoordinators, navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
