//
//  StudyTabCoordinator.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/17.
//

import UIKit

//MARK: - 2번째 탭인 스터디목록을 담당할 Coordinator입니다.

class StudyTabCoordinator: TabCoordinator {
    var delegate: AppCoordinator?
    var tabBarItem: UITabBarItem?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let vc = StudyListViewController()
//        vc.coordinator = self
//        vc.tabBarItem = self.tabBarItem
//        navigationController.pushViewController(vc, animated: true)
        
        //testCode
        showCreateStudy()
    }
    
     func showCreateStudy(){
        // #TODO: 1. VC생성, 2. VC에 Coordinator 주입, 3. 자식 코디네이터에 추가하여 할당해제 방지
        let coordinator = CreateStudyStep1Coordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func finish() {}
}
