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
        let nav = UIStoryboard.init(name: "Home", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let homeVC = nav.viewControllers.first as! HomeViewController
        return homeVC
    }

    static var keepListViewController: KeepListViewController {
        let nav = UIStoryboard.init(name: "KeepList", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let keepListVC = nav.viewControllers.first as! KeepListViewController
        return keepListVC
    }

    static var postViewController: PostViewController {
        let nav = UIStoryboard.init(name: "Post", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let postVC = nav.viewControllers.first as! PostViewController
        return postVC
    }

    static var profileViewController: ProfileViewController {
        let nav = UIStoryboard.init(name: "Profile", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let profileVC = nav.viewControllers.first as! ProfileViewController
        return profileVC
    }

    static var editProfileViewController: EditProfileViewController {
        let nav = UIStoryboard.init(name: "EditProfile", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let editProfileVC = nav.viewControllers.first as! EditProfileViewController
        return editProfileVC
    }

    static var settingsViewController: SettingsViewController {
        let nav = UIStoryboard.init(name: "Settings", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let settingsVC = nav.viewControllers.first as! SettingsViewController
        return settingsVC
    }
}
