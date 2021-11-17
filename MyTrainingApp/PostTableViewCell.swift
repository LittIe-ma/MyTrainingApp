//
//  PostTableViewCell.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/17.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PostTableViewCell"
    @IBOutlet private weak var postPofileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        postPofileImageView.setCircle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
