//
//  AppPresenter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol AppPresentation: AnyObject {
    func didFinishLaunch()
}

class AppPresenter {
    private let router: AppWireframe

    init(router: AppWireframe) {
        self.router = router
    }
}

extension AppPresenter: AppPresentation {
    func didFinishLaunch() {
        router.showMainView()
    }
}
