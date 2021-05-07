//
//  MainRouter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol MainWireframe {

}

class MainRouter {
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules() -> UIViewController {
        let view = MainViewController()
        view.setTabBarViewControllers(getViewControllers())
        let router = MainRouter(viewController: view)

        let presenter = MainPresenter(
            view: view,
            router: router
        )

        view.presenter = presenter

        return view
    }

    /// タブのViewControllerを返す
    static func getViewControllers() -> [UIViewController] {
        return [
            HomeRouter.assembleModules(),
            SearchRouter.assembleModeuls()
        ].map { UINavigationController(rootViewController: $0) }
    }
}

extension MainRouter: MainWireframe {

}
