//
//  HomeTableViewCell.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/05/08.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var nutritionNameLabel: UILabel!
    @IBOutlet weak var nutritionValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(nutrition: UserNutrition) {
        nutritionNameLabel.text = nutrition.nutritionName
        nutritionValueLabel.text = nutrition.nutritionValue.description
    }
}
