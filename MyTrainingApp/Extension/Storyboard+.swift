//
//  StatusBar.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/14.
//

import UIKit

extension UIStoryboard {
    static var tabBarController: TabBarController {
        UIStoryboard.init(name: "Root", bundle: nil).instantiateInitialViewController() as! TabBarController
    }

    static var homeViewController: HomeViewController {
        let navigation = UIStoryboard.init(name: "Home", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let homeVC = navigation.viewControllers.first as! HomeViewController
        return homeVC
    }

    static var keepListViewController: KeepListViewController {
        let navigation = UIStoryboard.init(name: "KeepList", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let keepListVC = navigation.viewControllers.first as! KeepListViewController
        return keepListVC
    }

    static var postViewController: PostViewController {
        let navigation = UIStoryboard.init(name: "Post", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let postVC = navigation.viewControllers.first as! PostViewController
        return postVC
    }

    static var profileViewController: ProfileViewController {
        let navigation = UIStoryboard.init(name: "Profile", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let profileVC = navigation.viewControllers.first as! ProfileViewController
        return profileVC
    }

    static var editProfileViewController: EditProfileViewController {
        let navigation = UIStoryboard.init(name: "EditProfile", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let editProfileVC = navigation.viewControllers.first as! EditProfileViewController
        return editProfileVC
    }

    static var settingsViewController: SettingsViewController {
        let navigation = UIStoryboard.init(name: "Settings", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let settingsVC = navigation.viewControllers.first as! SettingsViewController
        return settingsVC
    }
}
