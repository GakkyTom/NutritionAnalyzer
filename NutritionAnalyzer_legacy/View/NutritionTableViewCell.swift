//
//  NutritionTableViewCell.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/05.
//

import Foundation
import UIKit

class NutritionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    func setupCell(nutrition: Nutrition) {
        self.titleLabel.text = nutrition.foodName
    }
}
