//
//  EditProfileViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/13.
//

import UIKit
import Firebase

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
    @IBOutlet private weak var editProfileImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
        editProfileImageView.setCircle()
    }

    @IBAction func exitByCancel(_ sender: Any) {
        Router.shared.backProfile(from: self)
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
    }
}
