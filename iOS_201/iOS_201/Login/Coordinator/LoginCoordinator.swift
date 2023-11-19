//
//  LoginCoordinator.swift
//  iOS_201
//
//  Created by Hyeonho on 11/19/23.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    var delegate: AppCoordinator?
    
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController
    
    init(childCoordinators: [Coordinator], navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LoginViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    

    
    
}
