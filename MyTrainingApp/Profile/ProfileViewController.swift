//
//  ProfileViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit

class ProfileViewController: UIViewController {

    static func makeFromStoryboard() -> ProfileViewController {
        let vc = UIStoryboard.profileViewController
        return vc
    }

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var benchPressLabel: UILabel!
    @IBOutlet private weak var squatLabel: UILabel!
    @IBOutlet private weak var deadLiftLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton! {
        didSet {
            editProfileButton.addTarget(self, action: #selector(didTapEditProfile(_:)), for: .touchUpInside)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setStatusBarbackgroundColor(.green)
        setUpLabel()
        profileImageView.setCircle()
    }

    private func setUpLabel() {
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

