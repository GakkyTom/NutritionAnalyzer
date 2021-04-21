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
    static func assembleModules(food: Nutrition) -> UIViewController {
        let view = DetailViewController()
        let router = DetailRouter(viewController: view)

        let presenter = DetailPresenter(
            view: view,
            router: router,
            food: food
        )

        view.presenter = presenter

        return view
    }
}

extension DetailRouter: DetailWireframe {

}
