//
//  MyPageTabCoordinator.swift
//  iOS_201
//
//  Created by Hyeonho on 11/20/23.
//

import Foundation
import UIKit

class MyPageTabCoordinator: TabCoordinator {
    var delegate: AppCoordinator?
    var tabBarItem: UITabBarItem?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MypageViewController()
        vc.coordinator = self
        vc.tabBarItem = self.tabBarItem
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {}
    
    
}
