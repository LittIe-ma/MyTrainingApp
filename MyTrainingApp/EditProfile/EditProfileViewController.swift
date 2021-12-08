//
//  EditProfileViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/13.
//

import UIKit
import Firebase
import FirebaseStorage
import Kingfisher

class EditProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    static func makeFromStoryboard() -> EditProfileViewController {
        let editProfileVC = UIStoryboard.editProfileViewController
        return editProfileVC
    }

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var heightTextField: UITextField!
    @IBOutlet private weak var weightTextField: UITextField!
    @IBOutlet private weak var benchPressTextField: UITextField!
    @IBOutlet private weak var squatTextField: UITextField!
    @IBOutlet private weak var deadLiftTextField: UITextField!
    @IBOutlet private weak var editProfileImageView: UIImageView! {
        didSet {
            editProfileImageView.setCircle()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
        firestoreGetData()
        displayProfileImage()
    }

    @IBAction func exitByCancel(_ sender: Any) {
        Router.shared.backProfile(from: self)
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
        nameTextField.text = name
        heightTextField.text = height
        weightTextField.text = weight
        benchPressTextField.text = benchPress
        squatTextField.text = squat
        deadLiftTextField.text = deadLift
    }

    @IBAction func didTapSave(_ sender: Any) {
        guard !(nameTextField.text ?? "").isEmpty else {
            let dialog = UIAlertController(title: "Name is empty field.", message: "Please enter your name.", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
            return
        }

        let name = nameTextField.text ?? ""
        let height = heightTextField.text ?? "Not entered"
        let weight = weightTextField.text ?? "Not entered"
        let benchPress = benchPressTextField.text ?? "Not entered"
        let squat = squatTextField.text ?? "Not entered"
        let deadLift = deadLiftTextField.text ?? "Not entered"
        firestoreSetData(name: name, height: height, weight: weight, benchPress: benchPress, squat: squat, deadLift: deadLift)

        Router.shared.backProfile(from: self)
    }

    private func firestoreSetData(name: String, height: String, weight: String, benchPress: String, squat: String, deadLift: String) {
        guard let user = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(user).setData([
            "name": name,
            "height": height,
            "weight": weight,
            "benchPress": benchPress,
            "squat": squat,
            "deadLift": deadLift
        ], completion: { error in
            if let error = error {
                print("プロフィール更新失敗　" + error.localizedDescription)
            } else {
                print("プロフィール更新成功")
            }
        })
    }

    private func displayProfileImage() {
        let storageRef = Storage.storage().reference(forURL: "gs://mytrainingapp-9ffaa.appspot.com")
        let defaultProfileImageRef = storageRef.child("DefaultProfileImage.jpeg")
        defaultProfileImageRef.downloadURL { url, error in
            if let error = error {
                print("画像取得失敗" + error.localizedDescription)
            } else {
                print("画像取得成功 url: \(String(describing: url))")
                self.editProfileImageView.kf.setImage(with: url)
            }
        }
    }

    @IBAction func didTapProfileImageChange(_ sender: Any) {
        print("tapped profile image")
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    private func setupTextField() {
        nameTextField.delegate = self
        heightTextField.delegate = self
        weightTextField.delegate = self
        benchPressTextField.delegate = self
        squatTextField.delegate = self
        deadLiftTextField.delegate = self
        
        nameTextField.setUnderLine()
        heightTextField.setUnderLine()
        weightTextField.setUnderLine()
        benchPressTextField.setUnderLine()
        squatTextField.setUnderLine()
        deadLiftTextField.setUnderLine()

        heightTextField.keyboardType = .numberPad
        weightTextField.keyboardType = .numberPad
        benchPressTextField.keyboardType = .numberPad
        squatTextField.keyboardType = .numberPad
        deadLiftTextField.keyboardType = .numberPad
    }
}
