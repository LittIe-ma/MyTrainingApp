//
//  UIImageView+.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/21.
//

import UIKit

extension UIImageView {
    func setCircle() {
        layer.cornerRadius = self.frame.width / 2
        self.contentMode = .scaleAspectFill
    }
}
