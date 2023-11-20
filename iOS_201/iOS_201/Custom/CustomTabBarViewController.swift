//
//  CustomTabBarViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/03.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    weak var appCoordinator: AppCoordinator?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    // MARK: - Configure UI
    
    private func configureTabBar(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().backgroundColor = .black02
        tabBar.isTranslucent = false
        setViewControllers([createHomeTab(), createStudyListTab(), createMessageTab(), createMyPageTab()], animated: true)
        selectedIndex = 1
    }
    
    // MARK: - Set TabBar's ViewControllers
    
    private func createHomeTab() -> UINavigationController {
        let item = configureTabBarItemTitle(title: "홈", imageName: "homeTab")
        let VC = HomeViewController()
        VC.tabBarItem = item
        return UINavigationController(rootViewController: VC)
    }

    
    private func createStudyListTab() -> UINavigationController {
        let nav = UINavigationController()
        let item = configureTabBarItemTitle(title: "스터디목록", imageName: "studyListTab")
        let coordinator = StudyTabCoordinator(navigationController: nav)
        coordinator.tabBarItem = item
        coordinator.delegate = appCoordinator
        coordinator.start()
        self.appCoordinator?.studyTabCoordinator = StudyTabCoordinator(navigationController: nav)
        return nav
    }
    
    private func createMessageTab() -> UINavigationController{
        let item = configureTabBarItemTitle(title: "쪽지", imageName: "messageTab")
        let VC = MessageViewController()
        VC.tabBarItem = item
        return UINavigationController(rootViewController: VC)

    }
    
    private func createMyPageTab() -> UINavigationController{
        let nav = UINavigationController()
        let item = configureTabBarItemTitle(title: "마이페이지", imageName: "myPageTab")
        let coordinator = MyPageTabCoordinator(navigationController: nav)
        coordinator.tabBarItem = item
        coordinator.delegate = appCoordinator
        coordinator.start()
        self.appCoordinator?.studyTabCoordinator = StudyTabCoordinator(navigationController: nav)
        return nav
    }
    
    private func configureTabBarItemTitle(title:String, imageName: String ) -> UITabBarItem{
        let item = UITabBarItem(title: title, image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal),
                                selectedImage: UIImage(named: imageName + "Fill")?.withRenderingMode(.alwaysOriginal))
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green06], for: .selected)
        return item
    }
    
    //MARK: - TabBarViewController Methods
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
