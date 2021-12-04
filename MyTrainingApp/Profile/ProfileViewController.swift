//
//  ProfileViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    static func makeFromStoryboard() -> ProfileViewController {
        let profileVC = UIStoryboard.profileViewController
        return profileVC
    }

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var benchPressLabel: UILabel!
    @IBOutlet private weak var squatLabel: UILabel!
    @IBOutlet private weak var deadLiftLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.setCircle()
        }
    }
    @IBOutlet weak var editProfileButton: UIButton! {
        didSet {
            editProfileButton.addTarget(self, action: #selector(didTapEditProfile(_:)), for: .touchUpInside)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabel()
        firestoreGetData()
    }

    private func firestoreGetData() {
        guard let user = Auth.auth().currentUser?.uid else { return }
        let usersRef = Firestore.firestore().collection("users").document(user)
        usersRef.getDocument(completion: { (document, error) in
            if let document = document {
                let name = document.get("name")
                let height = document.get("height")
                let weight = document.get("weight")
                let benchPress = document.get("benchPress")
                let squat = document.get("squat")
                let deadLift = document.get("deadLift")
                self.nameLabel.text = name as? String
                self.heightLabel.text = height as? String
                self.weightLabel.text = weight as? String
                self.benchPressLabel.text = benchPress as? String
                self.squatLabel.text = squat as? String
                self.deadLiftLabel.text = deadLift as? String
            } else if let error = error {
                print("ユーザー情報取得失敗　" + error.localizedDescription)
                let dialog = UIAlertController(title: "Data acquisition failure", message: error.localizedDescription, preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "reload", style: .default, handler: { _ in
                    self.firestoreGetData()
                }))
                self.present(dialog, animated: true, completion: nil)
            }
        })
    }

    private func setupLabel() {
        nameLabel.setUnderLine()
        heightLabel.setUnderLine()
        weightLabel.setUnderLine()
        benchPressLabel.setUnderLine()
        squatLabel.setUnderLine()
        deadLiftLabel.setUnderLine()
    }

    @objc private func didTapEditProfile(_ sender: UIResponder) {
        Router.shared.showEditProfile(from: self)
    }
}
