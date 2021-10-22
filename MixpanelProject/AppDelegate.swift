//
//  AppDelegate.swift
//  MixpanelProject
//
//  Created by khoirunnisa' rizky noor fatimah on 12/10/21.
//

import UIKit
import Mixpanel

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let token = "f1a80d4c51e5cdead420aca8746f840e"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Mixpanel.initialize(token: token)
        if let uuid = UserDefaults.standard.string(forKey: "uuid") {
            Mixpanel.mainInstance().identify(distinctId: uuid)
            Mixpanel.mainInstance().registerSuperProperties(["uud": uuid])
            Mixpanel.mainInstance().people.set(properties: ["uuid": uuid])
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

