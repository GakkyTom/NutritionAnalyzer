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
    private let nutritionStaticsInteractor: NutritionStaticsUsecase

    init(view: HomeView,
         router: HomeWireframe,
         nutritionStaticsInteractor: NutritionStaticsUsecase) {
        self.view = view
        self.router = router
        self.nutritionStaticsInteractor = nutritionStaticsInteractor
    }
}

extension HomePresenter: HomePresentation {

}
