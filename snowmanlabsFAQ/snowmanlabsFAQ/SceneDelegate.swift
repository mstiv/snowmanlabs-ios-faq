//
//  SceneDelegate.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 21/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let isUserOnPad = (UIDevice.current.userInterfaceIdiom == .pad)

        //Configuring NavigationController appearance
        let navigationControllerAppearance = UINavigationBarAppearance()
        

        if (isUserOnPad) {
            let ipadTitleFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationControllerAppearance.titleTextAttributes = ipadTitleFont
        } else {
            navigationControllerAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        navigationControllerAppearance.backgroundColor = UIColor(named: "snowmanlabs_blue")
        
        //Set navigationBar new appearance
        UINavigationBar.appearance().standardAppearance = navigationControllerAppearance
        UINavigationBar.appearance().compactAppearance = navigationControllerAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationControllerAppearance
        
        //Configure rootViewController and set navigationController
        let rootViewController = FAQViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        //Configuring application main window
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: sceneWindow.coordinateSpace.bounds)
        self.window?.windowScene = sceneWindow
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
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


}

