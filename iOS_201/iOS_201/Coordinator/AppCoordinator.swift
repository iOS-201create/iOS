import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set}
    
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        /// 첫시작은 BoardVC 차후 로그인/ 자동로그인 유무에 따라 조건추가 가능
        goToLoginView()
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
        UIApplication.shared.keyWindow?.replaceRootViewController(vc, animated: true, completion: nil)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
