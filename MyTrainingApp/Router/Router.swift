//
//  Router.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/21.
//

import UIKit

final class Router {

    static let shared: Router = .init()
    private init() {}

    private var window: UIWindow?

    func showRoot(window: UIWindow?) {
        let viewController = TabBarController.makeFromStoryboard()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        self.window = window
//        let vccController = LoginViewController.makeFromStoryboard()
//        window?.rootViewController = viewController
//        window?.makeKeyAndVisible()
//        self.window = window
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
