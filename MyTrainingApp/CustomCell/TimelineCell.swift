//
//  PostTableViewCell.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/17.
//

import UIKit

final class TimelineCell: UITableViewCell {

    @IBOutlet private weak var postProfileImageView: UIImageView! {
        didSet {
            postProfileImageView.setCircle()
        }
    }
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var postedOnLabel: UILabel!

    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil)}

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
