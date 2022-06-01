//
//  FeedCell.swift
//  SharingPhotoApplication
//
//  Created by Veysel Can Bingöl on 31.05.2022.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
