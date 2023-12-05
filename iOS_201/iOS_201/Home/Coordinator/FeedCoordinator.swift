//
//  FeedCoordinator.swift
//  iOS_201
//
//  Created by Hyeonho on 12/4/23.
//

import Foundation
import UIKit

class FeedCoordinator: NavigationCoordinator {
    var delegate: NavigationCoordinator?
    
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController
    
    init(childCoordinators: [Coordinator], navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FeedViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    

}
