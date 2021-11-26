//
//  SignUpViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/24.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passWordField: UITextField!
    @IBOutlet private weak var userNameField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton! {
        didSet {
            loginButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
        }
    }

    static func makeFromStoryboard() -> SignUpViewController {
        let signUpVC = UIStoryboard.signUpViewController
        return signUpVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @objc private func didTapLogin(_ sender: UIResponder) {
        Router.shared.backLogin(from: self)
    }
}
