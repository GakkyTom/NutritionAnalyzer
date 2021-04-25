//
//  SearchResultTableViewCell.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/23.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var proteinQuantityLabel: UILabel!
    @IBOutlet weak var fatQuantityLabel: UILabel!
    @IBOutlet weak var carboQuantityLabel: UILabel!

    static let cellHeight: CGFloat = 70

    func setupCell(food: Food) {
        self.foodNameLabel.text = food.foodName
        self.proteinQuantityLabel.text = food.getNutritionValueOf(.protein).description
        self.fatQuantityLabel.text = food.getNutritionValueOf(.fat).description
        self.carboQuantityLabel.text = food.getNutritionValueOf(.carbohydrate).description
    }
}
