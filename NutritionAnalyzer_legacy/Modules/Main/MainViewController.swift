//
//  MainViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol MainView: AnyObject {
    func setTabBarViewControllers(_ viewControllers: [UIViewController])
}

class MainViewController: UITabBarController {
    var presenter: MainPresentation!
}

extension MainViewController: MainView {
    func setTabBarViewControllers(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}
