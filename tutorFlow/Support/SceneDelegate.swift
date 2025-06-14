//
//  SceneDelegate.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 03.06.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navVC = UINavigationController(rootViewController: ScheduleViewController())
        self.window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
}
