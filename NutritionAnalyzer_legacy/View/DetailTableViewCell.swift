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
    var nutritionId: Int?

    func setupCell(nutrition: UserNutrition) {
        self.nutritionNameLabel.text = nutrition.nutritionName
        self.nutritionValueLabel.text = nutrition.nutritionValue.description
    }

    func reCalcCell(nutrition: Nutrition, g: Double) {
        self.nutritionValueLabel.text = (nutrition.nutritionValue * g / 100).description
    }
}
