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

    func setupCell(nutrition: Nutrition) {
        self.foodNameLabel.text = nutrition.foodName
        self.proteinQuantityLabel.text = nutrition.protein.description
        self.fatQuantityLabel.text = nutrition.fat.description
        self.carboQuantityLabel.text = nutrition.carbohydrate.description
    }

//    func setupCellAppearance() {
//        self.percentageBackgroundView.layer.cornerRadius = 10
//        self.percentageBackgroundView.layer.shadowOffset = CGSize(width: 5, height: 5)
//        self.percentageBackgroundView.layer.shadowOpacity = 0.5
//
//    }
}
