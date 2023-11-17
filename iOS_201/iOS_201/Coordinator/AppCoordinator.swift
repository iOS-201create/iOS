import Foundation
import UIKit


protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set}
    func start()
}

///
protocol TabCoordinator: Coordinator {
    var delegate: AppCoordinator? { get set }
}
protocol NavigationCoordinator: Coordinator {
    var delegate: NavigationCoordinator? { get set }
}

extension NavigationCoordinator {
    
    func finish(){
        childCoordinators.removeAll()
        navigationController.popViewController(animated: true)
    }
    
    func removeChildCoordinator(_ childCoordinator: NavigationCoordinator){
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //TODO: - 4개의 탭 coordinator를 가질 예정
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
class StudyTabCoordinator: TabCoordinator {
    var delegate: AppCoordinator?
    
    var tabBarItem: UITabBarItem?
    var childCoordinators: [Coordinator] = []
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
    
    func showCreateStudy(_ delegate: NavigationCoordinator){
        // #TODO: 1. VC생성, 2. VC에 Coordinator 주입, 3. 자식 코디네이터 추가
        let coordinator = CreateStudyStep1Coordinator(navigationController: navigationController)
        coordinator.delegate = delegate
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func finish() {
        
    }
    
}
