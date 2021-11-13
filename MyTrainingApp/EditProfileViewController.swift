//
//  EditProfileViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/13.
//

import UIKit

class EditProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet private weak var nameInputField: UITextField!
    @IBOutlet private weak var heightInputField: UITextField!
    @IBOutlet private weak var weightInputField: UITextField!
    @IBOutlet private weak var benchPressInputField: UITextField!
    @IBOutlet private weak var squatInputField: UITextField!
    @IBOutlet private weak var deadLiftInputField: UITextField!
    @IBOutlet private weak var profileImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        setUpTextField()
    }

    @IBAction func exitByCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapProfileImageChange(_ sender: Any) {
        print("tapped profile image")
    }

    private func configureView() {
        setStatusBarbackgroundColor(.green)
    }

    private func setUpTextField() {
        nameInputField.setUnderLine()
        heightInputField.setUnderLine()
        weightInputField.setUnderLine()
        benchPressInputField.setUnderLine()
        squatInputField.setUnderLine()
        deadLiftInputField.setUnderLine()
    }

}

extension UITextField {
    func setUnderLine() {
        let underLine = UIView()
        underLine.frame = CGRect(x: 0, y: frame.height, width: UIScreen.main.bounds.size.width, height: 2)
        underLine.backgroundColor = .purple
        addSubview(underLine)
        bringSubviewToFront(underLine)
    }
}
