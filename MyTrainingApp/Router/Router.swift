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
                        let loginVC = LoginViewController.makeFromStoryboard()
                        window?.rootViewController = loginVC
                        window?.makeKeyAndVisible()
                        self.window = window
                    }
                }
            })
        } else {
            let loginVC = LoginViewController.makeFromStoryboard()
            window?.rootViewController = loginVC
            window?.makeKeyAndVisible()
            self.window = window
        }
    }

    func showEditProfile(from: UIViewController) {
        let editProfileVc = EditProfileViewController.makeFromStoryboard()
        show(from: from, next: editProfileVc)
    }

    func showSignUp(from: UIViewController) {
        let signUpVC = SignUpViewController.makeFromStoryboard()
        show(from: from, next: signUpVC)
    }

    func showResetPassword(from: UIViewController) {
        let resetPasswordVC = ResetPasswordViewController.makeFromStoryboard()
        show(from: from, next: resetPasswordVC)
    }

    func backProfile(from: UIViewController) {
        let profileVC = ProfileViewController.makeFromStoryboard()
        back(from: from, prev: profileVC)
    }

    func backLogin(from: UIViewController) {
        let loginVC = LoginViewController.makeFromStoryboard()
        back(from: from, prev: loginVC)
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

    func back(from: UIViewController, prev: UIViewController, animated: Bool = true) {
        if let navigationController = from.navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            from.dismiss(animated: animated, completion: nil)
        }
    }
}
