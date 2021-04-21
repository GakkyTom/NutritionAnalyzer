//
//  MainPresenter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol MainPresentation {
}

class MainPresenter {
    private weak var view: MainView?
    private let router: MainWireframe

    init(view: MainView,
         router: MainWireframe) {
        self.view = view
        self.router = router
    }
}

extension MainPresenter: MainPresentation {

}
