//
//  HomePresenter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol HomePresentation: AnyObject {

}

class HomePresenter {
    private weak var view: HomeView?
    private let router: HomeWireframe
    private let staticsRepositoryInteractor: StaticsRepositoryUsecase

    init(view: HomeView,
         router: HomeWireframe,
         staticsRepositoryInteractor: StaticsRepositoryUsecase) {
        self.view = view
        self.router = router
        self.staticsRepositoryInteractor = staticsRepositoryInteractor
    }
}

extension HomePresenter: HomePresentation {

}
