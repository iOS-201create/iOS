//
//  CreateStudyStep2Coordinator.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/17.
//

import UIKit

class CreateStudyStep2Coordinator: NavigationCoordinator {
    var delegate: NavigationCoordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, delegate: Coordinator) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CreateStudyStep2ViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }

}
