import Foundation
import UIKit

// MARK: - Coordinator Protocol
protocol Coordinator: AnyObject {
    // 기본적으로 Coordinator가 가져야할 프로토콜입니다.
    
    // Coordinator들의 할당 해제를 막기 위한 배열입니다.
    var childCoordinators: [Coordinator] { get set }

    var navigationController: UINavigationController { get set}
    func start()
}

extension Coordinator {
    
    /// navigation의 특성상 뒤로가기시, 자동으로 pop이 되기도 하고
    /// onBoarding에서 main으로 갈때는 기존의 child들을 다 삭제하고, rootView를 변경하는 작업이다보니
    /// LoginCoordinator와 onBoardingCoordinator를 모두다 삭제하는것도 좋아보여서 finish() 를 추가했습니다..!
    func finish(){
        childCoordinators.removeAll()
        navigationController.popViewController(animated: true)
    }
}

protocol TabCoordinator: Coordinator {
    // TabBarController에 붙는 Coordinator입니다.
    // 다른 예제들을 보면 탭간의 이동시에도 TabCoordinator를 사용하는 예재도 있습니다.
    // 하지만 apple이 이미 제공하는 화면전환 API가 있기 때문에 별 다른 메서드는 구현하지 않고 제외시켰습니다. (그냥 TabBarController - setViewControllers 사용 ... 굳이 해야하나?)
    
    // delegate는 부모 Coordinator가 들어가게됩니다.
    // start, finish와 같은 행동을 대신해서 처리해줍니다.
    var delegate: AppCoordinator? { get set }
}
protocol NavigationCoordinator: Coordinator {
    // 앱의 구조를 보게되면 각 4개의 Tab 하위에는 NavigationController가 하나씩 존재합니다.
    // 그리고 Tab 내에서 화면전환이 이루어질때는 이 NavigationController를 통해 이루어집니다.
    // 이 프로토콜은 Tab 한개당 하나씩 붙어 화면전환을 도와줍니다.
    
    // delegate는 부모 Coordinator가 들어가게됩니다.
    // start, finish와 같은 행동을 대신해서 처리해줍니다.
    var delegate: NavigationCoordinator? { get set }
}

extension NavigationCoordinator {
    // Coordinator가 역할을 다하고 뒤로가기를 하게됩니다.
    
    func finish(){
        childCoordinators.removeAll()
        navigationController.popViewController(animated: true)
        delegate?.removeChildCoordinator(self)
    }
    // 할당해제를 막기위해 자기 자신을 부모의 배열인 childCoordinator에 넣어놨었습니다.
    // 부모의 배열에서 자기 자신을 찾아서 삭제합니다.
    func removeChildCoordinator(_ childCoordinator: NavigationCoordinator){
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

class AppCoordinator: Coordinator {
    // OnBoarding, Login, TabBar(Main)의 화면전환을 관리하는 Coordinator입니다.
    
    var childCoordinators: [Coordinator] = []
    // OnBoarding, Login이 사용할 NavigationController입니다.
    // Tab을 가진 메인화면으로 이동할때는 RootView를 바꾸기 때문에 이 Navagation은 사용하지 않습니다.
    var navigationController: UINavigationController
    
    // CustomTabBarController.swift에서 각 객체를 생성하여 넣습니다.
    var studyTabCoordinator: StudyTabCoordinator? = nil
//    var homeTabCoordinator: HomeTabCoordinator? = nil
//    var MessageTabCoordinator: MessageTabCoordinator? = nil
    var myPageTabCoordinator: MyPageTabCoordinator? = nil
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        ///  UserDefault에 저장되어있기때문에 에뮬레이터 환경이 바뀔때마다, 다시 로그인을 해서 토큰을 발급받아주어야합니다 ㅠㅠㅠ
        ///  차후 키체인으로 변경시, 그후부턴 문제없을것입니다!!
        if let data = UserDefaults.standard.value(forKey:"authModel") as? Data,
           let _ = try? PropertyListDecoder().decode(AuthModel.self, from: data) {
            changeToMainView()
        } else {
            goToLoginView()
        }
        
        
    }
    
    func goToLoginView() {
        let coordinator = LoginCoordinator(childCoordinator: childCoordinators, navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func goToOnBoardingView() {
        let coordinator = OnBoardingCoordinator(childCoordinators: childCoordinators, navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
        
    }
    
    func changeToMainView() {
        let vc = CustomTabBarViewController()
        vc.appCoordinator = self
        self.navigationController.view.window?.rootViewController = vc
    }
}
