//
//  CreateStudyStep1Coordinator.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/17.
//

import UIKit

class CreateStudyStep1Coordinator: NavigationCoordinator {
    var delegate: NavigationCoordinator?

    var childCoordinators: [Coordinator]  = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CreateStudyStep1ViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        
    }
    
    func showNextStep(){
        let vc = CreateStudyStep2ViewController()
        let coordinator = CreateStudyStep2Coordinator(navigationController: navigationController, delegate: self)
        vc.coordinator = coordinator
        self.navigationController.pushViewController(vc, animated: true)
    }
}
