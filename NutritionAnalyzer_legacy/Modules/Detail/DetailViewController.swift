//
//  DetailViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol DetailView: AnyObject {

}

class DetailViewController: UIViewController {
    var presenter: DetailPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "detail"
    }
}

extension DetailViewController: DetailView {
    
}
