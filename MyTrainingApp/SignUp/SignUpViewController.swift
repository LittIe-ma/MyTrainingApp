//
//  SignUpViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/24.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    static func makeFromStoryboard() -> SignUpViewController {
        let signUpVC = UIStoryboard.signUpViewController
        return signUpVC
    }

    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton! {
        didSet {
            signUpButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet private weak var backLoginButton: UIButton! {
        didSet {
            backLoginButton.addTarget(self, action: #selector(didTapBackLogin(_:)), for: .touchUpInside)
        }
    }
    private let passwordHiddenButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
        setupKeyboard()
        setupPasswordHiddenButton()
    }

    @objc private func didTapBackLogin(_ sender: UIResponder) {
        Router.shared.backLogin(from: self)
    }

    @objc private func didTapSignUp(_ sender: Any) {
        guard !(nameField.text ?? "").isEmpty else {
            let dialog = UIAlertController(title: "There is an empty field.", message: "Please enter your name.", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
            return
        }
        
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        let name = nameField.text ?? ""
        signup(email: email, password: password, name: name)
    }

    private func signup(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
            if let user = result?.user {
                print("ユーザー作成完了　uid:" + user.uid)
                self.firestoreSetData(name: name, of: user)
            } else if let error = error {
                print("Firebase Auth 新規登録失敗 " + error.localizedDescription)
                let dialog = UIAlertController(title: "Registration Failure", message: error.localizedDescription, preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(dialog, animated: true, completion: nil)
            }
        })
    }

    private func firestoreSetData(name: String, of user: User) {
        Firestore.firestore().collection("users").document(user.uid).setData([
            "name": name
        ], completion: { error in
            if let error = error {
                print("Firestore 新規登録失敗 " + error.localizedDescription)
                let dialog = UIAlertController(title: "Registration Failure", message: error.localizedDescription, preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(dialog, animated: true, completion: nil)
            } else {
                print("ユーザー作成完了 name:" + name)
                self.sendEmailVerification(to: user)
            }
        })
    }

    private func sendEmailVerification(to user: User) {
        user.sendEmailVerification { error in
            if let error = error {
                print("メールアドレス検証失敗 " + error.localizedDescription)
                let dialog = UIAlertController(title: "Email Verification Failure", message: error.localizedDescription, preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "Resend", style: .default, handler: { _ in
                    self.sendEmailVerification(to: user)
                }))
                dialog.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
                self.present(dialog, animated: true, completion: nil)
            } else {
                print("メールアドレス検証成功")
                let dialog = UIAlertController(title: "Temporary registration completed", message: "A confirmation email has been sent to the email address you entered.", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    Router.shared.backLogin(from: self)
                }))
                self.present(dialog, animated: true, completion: nil)
            }
        }
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

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    private func setupTextField() {
        emailField.delegate = self
        passwordField.delegate = self
        nameField.delegate = self
    }
}
