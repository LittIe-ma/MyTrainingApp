//
//  EditProfileViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/13.
//

import UIKit

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
