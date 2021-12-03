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
    private let passwordHiddenButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
        setupKeyboard()
        setupPasswordHiddenButton()
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

    private func setupPasswordHiddenButton() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: passwordField.frame.height * 0.7, height: passwordField.frame.height))
        passwordHiddenButton.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        passwordHiddenButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        view.backgroundColor = .clear
        passwordHiddenButton.tintColor = .black
        passwordHiddenButton.addTarget(self, action: #selector(passwordIsHidden), for: .touchUpInside)
        view.addSubview(passwordHiddenButton)
        passwordField.rightViewMode = .always
        passwordField.rightView = view
    }

    @objc private func passwordIsHidden() {
        passwordField.isSecureTextEntry.toggle()
        passwordHiddenButton.setImage(UIImage(systemName: passwordField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"), for: .normal)
    }

    private func setupKeyboard() {
        passwordField.password()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    private func setupTextField() {
        emailField.delegate = self
        passwordField.delegate = self
    }
}
