//
//  NavigationController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/15.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().tintColor = .purple
        UINavigationBar.appearance().barTintColor = .green
    }
}
