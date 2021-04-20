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
        let router = HomeRouter(viewController: view)
        let staticsRepositoryInteractor = StaticsRepsitoryInteractor()

        let presenter = HomePresenter(
            view: view,
            router: router,
            staticsRepositoryInteractor: staticsRepositoryInteractor
        )

        view.presenter = presenter

        return view
    }
}

extension HomeRouter: HomeWireframe {

}
