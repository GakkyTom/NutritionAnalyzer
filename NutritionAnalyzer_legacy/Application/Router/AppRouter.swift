//
//  AppRouter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol AppWireframe: AnyObject {
    func showMainView()
}

class AppRouter {
    private let window: UIWindow

    private init(window: UIWindow) {
        self.window = window
    }

    static func assembleModules(window: UIWindow) -> AppPresentation {
        let router = AppRouter(window: window)
        let presenter = AppPresenter(router: router)

        return presenter
    }
}

extension AppRouter: AppWireframe {

    func showMainView() {
        let mainView = MainRouter.assembleModules()

        window.rootViewController = mainView
        window.makeKeyAndVisible()
    }
}
