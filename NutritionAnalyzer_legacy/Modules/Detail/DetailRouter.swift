//
//  DetailRouter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol DetailWireframe: AnyObject {

}

class DetailRouter {
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules(foodId: Int) -> UIViewController {
        let view = DetailViewController()
        let router = DetailRouter(viewController: view)
        let searchFoodInteractor = FoodInteractor()

        let presenter = DetailPresenter(
            view: view,
            router: router,
            searchFoodInteractor: searchFoodInteractor,
            foodId: foodId
        )

        view.presenter = presenter

        return view
    }
}

extension DetailRouter: DetailWireframe {

}
