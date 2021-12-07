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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        firestoreGetData()
    }

    private func firestoreGetData() {
        guard let user = Auth.auth().currentUser?.uid else { return }
        let usersRef = Firestore.firestore().collection("users").document(user)
        usersRef.getDocument(completion: { (document, error) in
            if let document = document {
                print("ユーザー情報取得成功")
                let name = document.get("name")
                let height = document.get("height")
                let weight = document.get("weight")
                let benchPress = document.get("benchPress")
                let squat = document.get("squat")
                let deadLift = document.get("deadLift")
                self.displayProfileData(name: name as! String,
                                        height: height as! String,
                                        weight: weight as! String,
                                        benchPress: benchPress as! String,
                                        squat: squat as! String,
                                        deadLift: deadLift as! String
                )
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

    private func displayProfileData(name: String, height: String, weight: String, benchPress: String, squat: String, deadLift: String) {
        nameLabel.text = name
        heightLabel.text = height
        weightLabel.text = weight
        benchPressLabel.text = benchPress
        squatLabel.text = squat
        deadLiftLabel.text = deadLift
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
