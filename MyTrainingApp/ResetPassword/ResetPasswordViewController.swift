//
//  ResetPasswordViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/12/03.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    static func makeFromStoryboard() -> ResetPasswordViewController {
        let resetPasswordVC = UIStoryboard.resetPasswordViewController
        return resetPasswordVC
    }

    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var sendEmailButton: UIButton! {
        didSet {
            sendEmailButton.addTarget(self, action: #selector(didTapSendEmail(_:)), for: .touchUpInside)
        }
    }

    @IBOutlet weak var backLoginButton: UIButton! {
        didSet {
            backLoginButton.addTarget(self, action: #selector(didTapBackLogin(_:)), for: .touchUpInside)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @objc private func didTapSendEmail(_ sender: Any) {
        sendPasswordReset()
    }

    private func sendPasswordReset() {
        let email = emailField.text ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: { error in
            if let error = error {
                print("パスワードリセットメール送信エラー　" + error.localizedDescription)
                let dialog = UIAlertController(title: "Send Failure", message: error.localizedDescription, preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(dialog, animated: true, completion: nil)
            } else {
                print("パスワードリセットメール送信完了")
                let dialog = UIAlertController(title: "Send Email", message: "Password reset email has been sent.", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    Router.shared.backLogin(from: self)
                }))
                dialog.addAction(UIAlertAction(title: "Resend", style: .destructive, handler: { _ in
                    self.sendPasswordReset()
                }))
                self.present(dialog, animated: true, completion: nil)
            }
        })
    }

    @objc private func didTapBackLogin(_ sender: Any) {
        Router.shared.backLogin(from: self)
    }
}
