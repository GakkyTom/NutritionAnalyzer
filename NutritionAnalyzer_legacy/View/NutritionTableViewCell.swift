//
//  NutritionTableViewCell.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/05.
//

import Foundation
import UIKit

class NutritionTableViewCell: UITableViewCell {

    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actualLabel: UILabel!
    @IBOutlet weak var plannedLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!

    // Views
    @IBOutlet weak var barBackgroundView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var percentageBackgroundView: UIView!

    // Constraints
    @IBOutlet weak var percentageConstraints: NSLayoutConstraint!
    @IBOutlet weak var barBackgroundWidth: NSLayoutConstraint!
    @IBOutlet weak var barWidth: NSLayoutConstraint!

    static let cellHeight: CGFloat = 73

    func setupCell(food: Food) {
        self.titleLabel.text = food.foodName
//        self.percentageLabel.text = "\((percentage * 100).description)%"
//        self.actualLabel.text = "\(actual.description)g"
//        self.plannedLabel.text = "\(planned.description)g"

        setupCellAppearance()
    }

    func setupCellAppearance() {
        self.percentageBackgroundView.layer.cornerRadius = 10
        self.percentageBackgroundView.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.percentageBackgroundView.layer.shadowOpacity = 0.5

    }
}
