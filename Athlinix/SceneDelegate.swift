//
//  SceneDelegate.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/17/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            checkAuthenticationStatus()
            
            // Handle deep link if the app was launched from one
            if let urlContext = connectionOptions.urlContexts.first {
                handleDeepLink(urlContext.url)
            }
        }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            // Handle deep link when the app is already running
            guard let url = URLContexts.first?.url else { return }
            handleDeepLink(url)
        }
    
    private func handleDeepLink(_ url: URL) {
        print("⚡️ Received Deep Link in SceneDelegate: \(url.absoluteString)") // Debug log

        // Convert URL query parameters into a dictionary
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
           let queryItems = components.queryItems {
            
            for queryItem in queryItems {
                print("🔍 Query Parameter: \(queryItem.name) = \(queryItem.value ?? "nil")") // Debugging log

                if queryItem.name == "code", let resetCode = queryItem.value {
                    print("✅ Reset Code Found: \(resetCode)")

                    // Navigate to ResetPasswordViewController with reset code
                    let resetVC = ResetPasswordViewController(nibName: "ResetPasswordViewController", bundle: nil)
                    resetVC.resetCode = resetCode 
                    let navController = UINavigationController(rootViewController: resetVC)

                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        let window = UIWindow(windowScene: windowScene)
                        window.rootViewController = navController
                        self.window = window
                        window.makeKeyAndVisible()
                    }
                    return
                }
            }
        }
        
        print("❌ No valid reset code found in deep link.")
    }

    
    
    
    private func checkAuthenticationStatus() {
            Task {
                do {
                    if (try await AuthServices.shared.checkSession()) != nil {
                        // Valid session exists, navigate to main app
                        await MainActor.run {
                            print("Valid session exists, navigate to main app")
                            navigateToMainScreen()
                        }
                    } else {
                        // No valid session, show login screen
                        await MainActor.run {
                            print("No valid session")
                            navigateToLogin()
                        }
                    }
                } catch {
                    // Handle session error, show login screen
                    await MainActor.run {
                        navigateToLogin()
                    }
                }
            }
        
        func navigateToMainScreen() {
            let tabBarController = TabBarController()
                window?.rootViewController = tabBarController
                window?.makeKeyAndVisible()
        }
        
        func navigateToLogin() {
            let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let navigationVC = UINavigationController(rootViewController: loginVC)
            window?.rootViewController = navigationVC
        }
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
    }


}

