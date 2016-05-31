//
//  SelfieCell.swift
//  Selfigram
//
//  Created by Shawn Crisp on 2016-05-27.
//  Copyright © 2016 Shawn Crisp. All rights reserved.
//

import UIKit

class SelfieCell: UITableViewCell {

    
    @IBOutlet weak var selfieImageView: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
