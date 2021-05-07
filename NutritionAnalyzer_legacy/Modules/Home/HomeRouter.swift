//
//  HomeRouter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol HomeWireframe: AnyObject {

}

class HomeRouter {
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules() -> UIViewController {
        let view = HomeViewController()
        view.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))

        let router = HomeRouter(viewController: view)
        let nutritionInteractor = NutritionInteractor()
        let userFoodInteractor = UserFoodInteractor()

        let presenter = HomePresenter(
            view: view,
            router: router,
            nutritionInteractor: nutritionInteractor,
            userFoodInteractor: userFoodInteractor
        )

        view.presenter = presenter

        return view
    }
}

extension HomeRouter: HomeWireframe {
    // TODO: 栄養素詳細へのRouting
}
