//
//  korusellApp.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/07.
//

import SwiftUI
import Firebase

@main
struct korusellApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("appOnboarded") var appOnboarded = false
   
    
    init() {
//        appOnboarded = false
        
        /// UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = UIColor(Color.gray10)
        /// Hides native TabBar
        UITabBar.appearance().isHidden = true
        /// Hides TextFieldBackground
//        UITextView.appearance().backgroundColor = .clear
        
/// use it for app onboarding tests
//        appOnboarded = false
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Auth.auth().languageCode = "ru"
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
}
