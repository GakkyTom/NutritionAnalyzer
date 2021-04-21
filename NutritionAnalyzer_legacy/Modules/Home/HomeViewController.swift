//
//  HomeViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol HomeView: AnyObject { }

class HomeViewController: UIViewController {

    var presenter: HomePresentation!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
    }
}

extension HomeViewController: HomeView {
    
}
