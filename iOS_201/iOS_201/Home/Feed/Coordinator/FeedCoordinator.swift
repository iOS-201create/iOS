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
    
    /// FeedViewModel에 넘겨줄 스터디정보
    var studyData: MyStudyModel
    
    init(childCoordinators: [Coordinator], navigationController: UINavigationController, studyData: MyStudyModel) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
        self.studyData = studyData
    }
    
    func start() {
        let viewmodel = FeedViewModel(studyData: studyData)
        let vc = FeedViewController(coordinator: self, viewmodel: viewmodel)
        navigationController.pushViewController(vc, animated: true)

    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }

}
