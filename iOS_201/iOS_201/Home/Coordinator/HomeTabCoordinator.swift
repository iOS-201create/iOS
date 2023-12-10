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
        childCoordinators.append(self)
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func finish() {}
    
    /// 스터디클릭시, 해당스터디의 정보 필요.
    func goToFeedView(studyData: MyStudyModel) {
        let coordinator = FeedCoordinator(childCoordinators: childCoordinators, navigationController: navigationController,studyData: studyData)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
