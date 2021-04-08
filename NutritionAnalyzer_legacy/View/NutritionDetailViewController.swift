//
//  NutritionDetailViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/06.
//

import UIKit

class NutritionDetailViewController: UIViewController {

    var data: Nutrition?
    static let storyboardName = "NutritionDetail"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbonLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        if let data = self.data {
            titleLabel.text = data.foodName
            proteinLabel.text = data.protein.description
            fatLabel.text = data.fat.description
            carbonLabel.text = data.carbohydrate.description
        }
    }

    @IBAction func onTapAddButton(_ sender: Any) {
        if let data = self.data {
            let model = NutritionModel()

            model.add(food: data)
            self.dismiss(animated: true, completion: nil)
        }
    }

    static func getViewController(data: Nutrition) -> NutritionDetailViewController {

        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = sb.instantiateInitialViewController() as! NutritionDetailViewController

        vc.data = data
        return vc
    }
}
