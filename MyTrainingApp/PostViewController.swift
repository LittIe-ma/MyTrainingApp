//
//  PostViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet private weak var postTextView: PlaceHolderTextView!
    @IBOutlet private weak var profileImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setStatusBarbackgroundColor(.green)
        profileImageView.setCircle()
        setPostButton()
        postTextView.placeHolder = "Training menu"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        postTextView.becomeFirstResponder()
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
}
