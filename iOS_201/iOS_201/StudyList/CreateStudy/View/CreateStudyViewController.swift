//
//  CreateStudyViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/16.
//

import UIKit

class CreateStudyViewController: UIViewController {
    
    var coordinator: CreateStudyCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }

}

class CreateStudyCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CreateStudyViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
}
