//
//  ViewControllerTableViewCell.swift
//  CharactersApp
//
//  Created by Amairany Servin Salazar on 4/24/19.
//  Copyright © 2019 Amairany Servin Salazar. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var lblWeakness: UILabel!
    @IBOutlet weak var lblUniverse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
