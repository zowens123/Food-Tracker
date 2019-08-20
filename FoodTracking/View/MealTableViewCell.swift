//
//  MealTableViewCell.swift
//  FoodTracking
//
//  Created by Zach Owens on 1/18/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    //mark: properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
