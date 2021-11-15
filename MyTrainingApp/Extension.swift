//
//  StatusBar.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/14.
//

import UIKit

extension UIViewController {
    private final class StatusBarView: UIView {}

    func setStatusBarbackgroundColor(_ color: UIColor?) {
        for subView in self.view.subviews where subView is StatusBarView {
            subView.removeFromSuperview()
        }
        guard let color = color else {
            return
        }
        let statusBarView = StatusBarView()
        statusBarView.backgroundColor = color
        self.view.addSubview(statusBarView)
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        statusBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        statusBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        statusBarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
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

extension UILabel {
    func setUnderLine() {
        let underLine = UIView()
        underLine.frame = CGRect(x: 0, y: frame.height, width: UIScreen.main.bounds.size.width, height: 2)
        underLine.backgroundColor = .purple
        addSubview(underLine)
        bringSubviewToFront(underLine)
    }
}

extension UIImageView {
    func setCircle() {
        layer.cornerRadius = self.frame.width / 2
    }
}
