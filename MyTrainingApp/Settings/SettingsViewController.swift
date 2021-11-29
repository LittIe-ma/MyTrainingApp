//
//  SettingsViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    static func makeFromStoryboard() -> SettingsViewController {
        let settingsVC = UIStoryboard.settingsViewController
        return settingsVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        testLogoutButton()
    }

    private func testLogoutButton() {
        let button = UIButton()
        button.frame = CGRect(x: self.view.frame.width/4, y: self.view.frame.height/2, width: self.view.frame.width/2, height: 50)
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(didTapLogout(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }

    @objc private func didTapLogout(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                print("ログアウト完了")
                Router.shared.showReStart()
            } catch let error as NSError {
                print("ログアウト失敗 " + error.localizedDescription)
                let dialog = UIAlertController(title: "Logout Failure", message: error.localizedDescription, preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(dialog, animated: true, completion: nil)
            }
        }
    }
}
