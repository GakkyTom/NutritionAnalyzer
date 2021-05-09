//
//  SearchRouter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

//import Foundation
import UIKit

protocol SearchWireframe: AnyObject {
    func showDetailOf(_ foodId: Int)
}

class SearchRouter {
    // 画面遷移用のViewController
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModeuls() -> UIViewController {
        let view = SearchViewController()
        view.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), selectedImage: UIImage(named: "search"))

        let router = SearchRouter(viewController: view)
        let foodInteractor = FoodInteractor()

        let presenter = SearchPresenter(view: view, router: router, foodInteractor: foodInteractor)

        view.presenter = presenter

        return view
    }
}

extension SearchRouter: SearchWireframe {
    func showDetailOf(_ foodId: Int) {
        let detailView = DetailRouter.assembleModules(foodId: foodId)

        // ここで、init時に受け取ったViewControllerを使う
        viewController.navigationController?.pushViewController(detailView, animated: true)
    }
}
