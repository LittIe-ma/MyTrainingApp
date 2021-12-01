//
//  PostViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit
import UITextView_Placeholder

class PostViewController: UIViewController, UITextFieldDelegate {

    static func makeFromStoryboard() -> PostViewController {
        let postVC = UIStoryboard.postViewController
        return postVC
    }

    @IBOutlet private weak var postTextView: UITextView!
    @IBOutlet private weak var profileImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.setCircle()
        setPostButton()
        setPlaceholder()
    }

    private func setPostButton() {
        let postButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        postButton.backgroundColor = .purple
        postButton.tintColor = .white
        postButton.setTitle("Post", for: .normal)
        postButton.layer.cornerRadius = 15
        postButton.addTarget(self, action: #selector(self.didTapPost), for: .touchUpInside)
        let item = UIBarButtonItem(customView: postButton)
        self.navigationItem.rightBarButtonItem = item
    }

    @objc private func didTapPost() {
        print("button tapped")
    }

    private func setPlaceholder() {
        postTextView.placeholder = "Training menu"
        postTextView.placeholderColor = .gray
    }

    @objc private func didTapDoneKeyBoard() {
        self.view.endEditing(true)
    }
}
