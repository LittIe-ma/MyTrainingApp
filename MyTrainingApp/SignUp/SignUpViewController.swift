//
//  SignUpViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/24.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var userNameField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton! {
        didSet {
            signUpButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)
        }
    }
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

    @objc private func didTapSignUp(_ sender: Any) {
        if let email = emailField.text,
           let password = passwordField.text,
           let name = userNameField.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
                if let user = result?.user {
                    print("ユーザー作成完了　uid:" + user.uid)
                    Firestore.firestore().collection("users").document(user.uid).setData([
                        "name": name
                    ], completion: { error in
                        if let error = error {
                            print("Firestore 新規登録失敗 " + error.localizedDescription)
                            let dialog = UIAlertController(title: "新規登録失敗", message: error.localizedDescription, preferredStyle: .alert)
                            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(dialog, animated: true, completion: nil)
                        } else {
                            print("ユーザー作成完了 name:" + name)
                            Router.shared.backLogin(from: self)
                        }
                    })
                } else if let error = error {
                    print("Firebase Auth 新規登録失敗 " + error.localizedDescription)
                    let dialog = UIAlertController(title: "新規登録失敗", message: error.localizedDescription, preferredStyle: .alert)
                    dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(dialog, animated: true, completion: nil)
                }
            })
        }
    }
}
