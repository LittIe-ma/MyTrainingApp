//
//  SettingsViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit

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

    }
}
