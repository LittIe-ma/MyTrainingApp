//
//  LoginViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton! {
        didSet {
            signUpButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)
        }
    }

    static func makeFromStoryboard() -> LoginViewController {
        let loginVC = UIStoryboard.loginViewController
        return loginVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @objc private func didTapSignUp(_ sender: UIResponder) {
        Router.shared.showSignUp(from: self)
    }
}
