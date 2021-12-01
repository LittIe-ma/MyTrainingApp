//
//  SettingsViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    static func makeFromStoryboard() -> SettingsViewController {
        let settingsVC = UIStoryboard.settingsViewController
        return settingsVC
    }

    @IBOutlet weak var settingsTableView: UITableView!

    let sectionTitleArray = ["ABOUT APPLICATION", "ACCOUNT"]
    let cellContentsArray = [
        ["Write review"],
        ["Logout", "Delete Account"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }

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
        case [0, 0]: // Write review
            print("00")
        case [1, 0]: // Logout
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
        case [1, 1]: // Delete Account
            print("11")
        default:
            break
        }
    }
}
