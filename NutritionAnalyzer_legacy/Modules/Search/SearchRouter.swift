//
//  SearchRouter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

//import Foundation
import UIKit

protocol SearchWireframe: AnyObject {
    func showDetailOf(_ food: Nutrition)
}

class SearchRouter {
    // 画面遷移用のViewController
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModeuls() -> UIViewController {
        let view = SearchViewController()
        let router = SearchRouter(viewController: view)
        let searchFoodInteractor = SearchFoodInteractor()

        let presenter = SearchPresenter(view: view, router: router, searchFoodInteractor: searchFoodInteractor)

        view.presenter = presenter

        return view
    }
}

extension SearchRouter: SearchWireframe {
    func showDetailOf(_ food: Nutrition) {
        let detailView = DetailRouter.assembleModules(food: food)

        // ここで、init時に受け取ったViewControllerを使う
        viewController.navigationController?.pushViewController(detailView, animated: true)
    }
}
