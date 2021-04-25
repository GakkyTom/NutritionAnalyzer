//
//  DetailTableViewCell.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/25.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nutritionNameLabel: UILabel!
    @IBOutlet weak var nutritionValueLabel: UILabel!

    static let cellHeight: CGFloat = 30

    func setupCell(nutrition: Nutrition) {
        self.nutritionNameLabel.text = nutrition.nutritionName
        self.nutritionValueLabel.text = nutrition.value.description
    }

    func reCalcCell(nutrition: Nutrition, g: Float) {
        self.nutritionValueLabel.text = (nutrition.value * g / 100).description
    }
}
