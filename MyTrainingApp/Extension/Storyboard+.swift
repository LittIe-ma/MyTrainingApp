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
        let vc = nav.viewControllers.first as! HomeViewController
        return vc
    }

    static var keepListViewController: KeepListViewController {
        let nav = UIStoryboard.init(name: "KeepList", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let vc = nav.viewControllers.first as! KeepListViewController
        return vc
    }

    static var postViewController: PostViewController {
        let nav = UIStoryboard.init(name: "Post", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let vc = nav.viewControllers.first as! PostViewController
        return vc
    }

    static var profileViewController: ProfileViewController {
        let nav = UIStoryboard.init(name: "Profile", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let vc = nav.viewControllers.first as! ProfileViewController
        return vc
    }

    static var editProfileViewController: EditProfileViewController {
        let nav = UIStoryboard.init(name: "EditProfile", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let vc = nav.viewControllers.first as! EditProfileViewController
        return vc
    }

    static var settingsViewController: SettingsViewController {
        let nav = UIStoryboard.init(name: "Settings", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let vc = nav.viewControllers.first as! SettingsViewController
        return vc
    }
}





