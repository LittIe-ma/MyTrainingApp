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

        UITabBar.appearance().tintColor = .purple
        UITabBar.appearance().barTintColor = .green
    }
}
