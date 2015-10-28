//
//  ItemCell.swift
//  Hownpwner
//
//  Created by Kelly Yamamoto on 10/28/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
 
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        serialNumberLabel.font = caption1Font
        
    }
    func updateValueLabels(amount: Int) {
       
        let lowValueColor = UIColor.greenColor()
        let highValueColor = UIColor.redColor()
        let valueLabelAmount = amount
        if valueLabelAmount < 50 {
            valueLabel.textColor = lowValueColor
        } else {
            valueLabel.textColor = highValueColor
        }
    }
}