//
//  StatusBar.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/14.
//

import UIKit

extension UIStoryboard {
    static var tabBarController: TabBarController {
        UIStoryboard.init(name: "TabBar", bundle: nil).instantiateInitialViewController() as! TabBarController
    }

    static var homeViewController: HomeViewController {
        UIStoryboard.init(name: "Home", bundle: nil).instantiateInitialViewController() as! HomeViewController
    }

    static var keepListViewController: KeepListViewController {
        UIStoryboard.init(name: "KeepList", bundle: nil).instantiateInitialViewController() as! KeepListViewController
    }

    static var postViewController: PostViewController {
        UIStoryboard.init(name: "Post", bundle: nil).instantiateInitialViewController() as! PostViewController
    }

    static var profileViewController: ProfileViewController {
        UIStoryboard.init(name: "Profile", bundle: nil).instantiateInitialViewController() as! ProfileViewController
    }

    static var editProfileViewController: EditProfileViewController {
        UIStoryboard.init(name: "EditProfile", bundle: nil).instantiateInitialViewController() as! EditProfileViewController
    }

    static var settingsViewController: SettingsViewController {
        UIStoryboard.init(name: "Settings", bundle: nil).instantiateInitialViewController() as! SettingsViewController
    }
}





