import Foundation
import UIKit

protocol BaseCoordinator {
    var childCoordinators: [BaseCoordinator] { get set }
    var navigationController: UINavigationController { get set}
    func start()
}

class AppCoordinator: BaseCoordinator {
    
    var childCoordinators: [BaseCoordinator] = []
    var navigationController: UINavigationController
    var studyTabCoordinator: StudyTabCoordinator? = nil
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        /// 첫시작은 BoardVC 차후 로그인/ 자동로그인 유무에 따라 조건추가 가능
        changeToMainView()
    }
    
    func goToLoginView() {
        let vc = LoginViewController()
        vc.viewmodel.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToOnBoardingView() {
        let vc = OnBoardingViewController()
        vc.viewmodel.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func changeToMainView() {
        let vc = CustomTabBarViewController()
        vc.appCoordinator = self
        UIApplication.shared.keyWindow?.replaceRootViewController(vc, animated: true, completion: nil)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}

// Tab: - home, study, chat, myPage
class StudyTabCoordinator: BaseCoordinator {
    var delegate: AppCoordinator?
    var tabBarItem: UITabBarItem?
    var childCoordinators: [BaseCoordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = StudyListViewController()
        vc.coordinator = self
        vc.tabBarItem = self.tabBarItem
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCreateStudy(){
        let coordinator = CreateStudyCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}

//
//protocol Coordinating {
//    var coordinator: BaseCoordinator? { get set }
//}
