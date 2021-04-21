//
//  DetailViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol DetailView: AnyObject {
    func updateLabels(food: Nutrition)
}

class DetailViewController: UIViewController {
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbohydrateLabel: UILabel!
    @IBOutlet weak var proteinQtLabel: UILabel!
    @IBOutlet weak var fatQtLabel: UILabel!
    @IBOutlet weak var carbohydrateQtLabel: UILabel!

    var presenter: DetailPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension DetailViewController: DetailView {
    func updateLabels(food: Nutrition) {
        self.title = food.foodName

        self.proteinQtLabel.text = food.protein.description
        self.fatQtLabel.text = food.fat.description
        self.carbohydrateQtLabel.text = food.carbohydrate.description
    }
}
