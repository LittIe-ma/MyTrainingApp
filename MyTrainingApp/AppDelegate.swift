//
//  AppDelegate.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Router.shared.showRoot(window: UIWindow(frame: UIScreen.main.bounds))
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        return true
    }
}
