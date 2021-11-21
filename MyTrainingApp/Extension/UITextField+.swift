//
//  UITextField+.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/21.
//

import UIKit

extension UITextField {
    func setUnderLine() {
        let underLine = UIView()
        underLine.frame = CGRect(x: 0, y: frame.height, width: UIScreen.main.bounds.size.width, height: 2)
        underLine.backgroundColor = .purple
        addSubview(underLine)
        bringSubviewToFront(underLine)
    }
}
