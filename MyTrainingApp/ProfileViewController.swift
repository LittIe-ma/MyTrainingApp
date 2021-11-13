//
//  ProfileViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var benchPressLabel: UILabel!
    @IBOutlet private weak var squatLabel: UILabel!
    @IBOutlet private weak var deadLiftLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        setUpLabel()
    }

    private func setUpLabel() {
        nameLabel.setUnderLine()
        heightLabel.setUnderLine()
        weightLabel.setUnderLine()
        benchPressLabel.setUnderLine()
        squatLabel.setUnderLine()
        deadLiftLabel.setUnderLine()
    }

    private func configureView() {
        setStatusBarbackgroundColor(.green)
    }

}

extension UILabel {
    func setUnderLine() {
        let underLine = UIView()
        underLine.frame = CGRect(x: 0, y: frame.height, width: UIScreen.main.bounds.size.width, height: 2)
        underLine.backgroundColor = .purple
        addSubview(underLine)
        bringSubviewToFront(underLine)
    }
}
