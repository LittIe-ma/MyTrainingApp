//
//  LoginViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    static func makeFromStoryboard() -> LoginViewController {
        let loginVC = UIStoryboard.loginViewController
        return loginVC
    }

    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var loginButton: UIButton! {
        didSet {
            loginButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var resetPasswordButton: UIButton! {
        didSet {
            resetPasswordButton.addTarget(self, action: #selector(didTapResetPassword(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet private weak var showSignUpButton: UIButton! {
        didSet {
            showSignUpButton.addTarget(self, action: #selector(didTapShowSignUp(_:)), for: .touchUpInside)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @objc private func didTapShowSignUp(_ sender: Any) {
        Router.shared.showSignUp(from: self)
    }

    @objc private func didTapLogin(_ sender: Any) {
        if let email = emailField.text,
           let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
                if let user = result?.user {
                    if Auth.auth().currentUser?.isEmailVerified == true {
                        print("ログイン完了　uid:" + user.uid)
                        Router.shared.showReStart()
                    } else if Auth.auth().currentUser?.isEmailVerified == false {
                        let dialog = UIAlertController(title: "Email verification has not yet been completed.", message: "We have sent you a confirmation email, please check it.", preferredStyle: .alert)
                        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(dialog, animated: true, completion: nil)
                    }
                } else if let error = error {
                    print("ログイン失敗 " + error.localizedDescription)
                    let dialog = UIAlertController(title: "Login Failure", message: error.localizedDescription, preferredStyle: .alert)
                    dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(dialog, animated: true, completion: nil)
                }
            })
        }
    }

    @objc private func didTapResetPassword(_ sender: Any) {
        Router.shared.showResetPassword(from: self)
    }
}
