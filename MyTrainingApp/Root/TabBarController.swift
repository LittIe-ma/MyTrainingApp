//
//  TabBarController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/15.
//

import UIKit

class TabBarController: UITabBarController {

    static func makeFromStoryboard() -> TabBarController {
        let root = UIStoryboard.tabBarController
        return root
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRootView()
    }

    private func setupRootView() {
        var viewControllers = [UIViewController]()
        let home = UIStoryboard.homeViewController
        let keep = UIStoryboard.keepListViewController
        let post = UIStoryboard.postViewController
        let profile = UIStoryboard.profileViewController
        let settings = UIStoryboard.settingsViewController
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)
        keep.tabBarItem = UITabBarItem(title: "Keep", image: UIImage(systemName: "star"), selectedImage: nil)
        post.tabBarItem = UITabBarItem(title: "Post", image: UIImage(systemName: "plus.square"), selectedImage: nil)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: nil)
        settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: nil)

        viewControllers = [home, keep, post, profile, settings]
        viewControllers = viewControllers.map { UINavigationController(rootViewController: $0) }
        setViewControllers(viewControllers, animated: false)

        setStatusBarbackgroundColor(.green)
        UINavigationBar.appearance().backgroundColor = .green
        UINavigationBar.appearance().barTintColor = .green
        UITabBar.appearance().tintColor = .purple
        UITabBar.appearance().barTintColor = .green
    }
}
