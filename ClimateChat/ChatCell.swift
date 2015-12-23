//
//  ChatCell.swift
//  ClimateChat
//
//  Created by Kelly Yamamoto on 10/13/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
