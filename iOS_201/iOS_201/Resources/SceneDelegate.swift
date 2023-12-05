//
//  SceneDelegate.swift
//  iOS_201
//
//  Created by 유준용 on 2023/10/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        self.coordinator = AppCoordinator(navigationController)
        coordinator?.start()
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    //TODO: 차후 준용님이 말해주신 부분처럼 웹뷰?? 로 변경하겠습니다!
    /// code를 받을시, onBoardingView로 화면은 전환합니다.
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if url.absoluteString.starts(with: "example://") {
                if let code = url.absoluteString.split(separator: "=").last.map({ String($0) }) {
                    coordinator?.goToOnBoardingView()
                    print(code)
                    AuthService.share.requestToken(with: code)
                }
            }
        }
    }
    
    
}


extension UIWindow {
    
    func replaceRootViewController(_ replacementController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        
        let snapshotImageView = UIImageView(image: self.snapshot())
        
        self.addSubview(snapshotImageView)
        
        let dismissCompletion = { () -> Void in // dismiss all modal view controllers
            
            self.rootViewController = replacementController
            
            self.bringSubviewToFront(snapshotImageView)
            
            if animated {
                UIView.animate(withDuration: 0.4, animations: { () -> Void in
                    
                    snapshotImageView.alpha = 0
                    
                }, completion: { (success) -> Void in
                    
                    snapshotImageView.removeFromSuperview()
                    
                    completion?()
                    
                })
                
            } else {
                snapshotImageView.removeFromSuperview()
                
                completion?()
            }
            
        }
        
        if self.rootViewController!.presentedViewController != nil {
            self.rootViewController!.dismiss(animated: false, completion: dismissCompletion)
            
        } else {
            dismissCompletion()
        }
    }
    
    func snapshot() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage.init() }
        
        UIGraphicsEndImageContext()
        
        return result
    }
    
}
