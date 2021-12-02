//
//  Router.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/21.
//

import UIKit
import Firebase

final class Router {

    static let shared: Router = .init()
    private init() {}

    private var window: UIWindow?

    func showRoot(window: UIWindow?) {
        if Auth.auth().currentUser?.uid != nil {
            Auth.auth().currentUser?.reload(completion: { error in
                if error == nil {
                    if Auth.auth().currentUser?.isEmailVerified == true {
                        let tabBarController = TabBarController.makeFromStoryboard()
                        window?.rootViewController = tabBarController
                        window?.makeKeyAndVisible()
                        self.window = window
                    } else if Auth.auth().currentUser?.isEmailVerified == false {
                        let viewController = LoginViewController.makeFromStoryboard()
                        window?.rootViewController = viewController
                        window?.makeKeyAndVisible()
                        self.window = window
                    }
                }
            })
        } else {
            let viewController = LoginViewController.makeFromStoryboard()
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
            self.window = window
        }
    }

    func showEditProfile(from: UIViewController) {
        let viewController = EditProfileViewController.makeFromStoryboard()
        show(from: from, next: viewController)
    }

    func showSignUp(from: UIViewController) {
        let viewController = SignUpViewController.makeFromStoryboard()
        show(from: from, next: viewController)
    }

    func backProfile(from: UIViewController) {
        let viewController = ProfileViewController.makeFromStoryboard()
        back(from: from, next: viewController)
    }

    func backLogin(from: UIViewController) {
        let viewController = LoginViewController.makeFromStoryboard()
        back(from: from, next: viewController)
    }

    func showReStart() {
        showRoot(window: window)
    }
}

private extension Router {
    func show(from: UIViewController, next: UIViewController, animated: Bool = true) {
        if let navigationController = from.navigationController {
            navigationController.pushViewController(next, animated: animated)
        } else {
            from.present(next, animated: animated, completion: nil)
        }
    }

    func back(from: UIViewController, next: UIViewController, animated: Bool = true) {
        if let navigationController = from.navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            from.dismiss(animated: animated, completion: nil)
        }
    }
}
