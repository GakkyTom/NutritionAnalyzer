//
//  HomeViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol HomeView: AnyObject { }

class HomeViewController: UIViewController {

    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbohydrateLabel: UILabel!

    var presenter: HomePresentation!

    override func viewDidLoad() {
        super.viewDidLoad() 

        self.title = "Home"

        let data = presenter.fetchUserData()
        data.forEach { (userPfc) in
            proteinLabel.text = "Protein: \(self.presenter.sumup("protein"))"
            fatLabel.text = "Fat: \(self.presenter.sumup("fat"))"
            carbohydrateLabel.text = "Carbohydrate: \(self.presenter.sumup("carbohydrate"))"
        }
    }
}

extension HomeViewController: HomeView {
    
}
