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

    @IBOutlet weak var settingsTableView: UITableView!

    let sectionTitleArray = ["ABOUT APPLICATION", "ACCOUNT"]
    let cellContentsArray = [
        ["Write review"],
        ["Logout", "Withdraw"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }

    private func logout() {
        let dialog = UIAlertController(title: "Would you like to logout?", message: "", preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
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
        }))
        dialog.addAction(UIAlertAction(title: "cancel", style: .cancel))
        self.present(dialog, animated: true, completion: nil)
    }

    private func withdraw() {
        let dialog = UIAlertController(title: "Are you sure you want to do this?", message: "", preferredStyle: .actionSheet)
        dialog.addAction(UIAlertAction(title: "Withdraw", style: .destructive, handler: { _ in
            self.firestoreDeleteData()
            Auth.auth().currentUser?.delete { error in
                if let error = error {
                    print("退会失敗" + error.localizedDescription)
                    let dialog = UIAlertController(title: "Withdraw Failure", message: error.localizedDescription, preferredStyle: .alert)
                    dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in self.loginDialog() }))
                    self.present(dialog, animated: true, completion: nil)
                } else {
                    print("退会完了")
                    Router.shared.showReStart()
                }
            }
        }))
        dialog.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }

    private func firestoreDeleteData() {
        guard let user = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(user).delete { error in
            if let error = error {
                print("ユーザー削除失敗　" + error.localizedDescription)
            } else {
                print("ユーザー削除完了")
            }
        }
    }

    private func loginDialog() {
        guard let userEmail = Auth.auth().currentUser?.email else { return }
        var passwordTextField: UITextField?
        let dialog = UIAlertController(title: "Login", message: "Please enter the \"\(userEmail)\" password.", preferredStyle: .alert)
        dialog.addTextField(configurationHandler: { (textField: UITextField) in
            passwordTextField = textField
            textField.placeholder = "Password"
            textField.password()
        })
        dialog.addAction(UIAlertAction(title: "Login", style: .default, handler: { _ in
            if let password = passwordTextField?.text {
                self.login(password: password)
            }
        }))
        dialog.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }

    private func login(password: String) {
        guard let email = Auth.auth().currentUser?.email else { return }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
            if let user = result?.user {
                print("ログイン完了 uid:" + user.uid)
                self.withdraw()
            } else if let error = error {
                print("ログイン失敗 " + error.localizedDescription)
                let dialog = UIAlertController(title: "Login Failure", message: error.localizedDescription, preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                dialog.addAction(UIAlertAction(title: "Retry", style: .destructive, handler: { _ in self.loginDialog() }))
                self.present(dialog, animated: true, completion: nil)
            }
        })
    }
 }

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        25
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitleArray[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellContentsArray[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cellContentsArray[indexPath.section][indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsTableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case [0, 0]: print("Write review")
        case [1, 0]: logout()
        case [1, 1]: withdraw()
        default: break
        }
    }
}
