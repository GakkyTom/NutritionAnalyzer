//
//  SearchPresenter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol SearchPresentation: AnyObject {
    func viewDidLoad()
    func didSelectRow(food: Nutrition)
}

class SearchPresenter {
    private weak var view: SearchView?
    private let router: SearchWireframe
    private let searchFoodInteractor: SearchFoodInteractor

    init(view: SearchView,
         router: SearchWireframe,
         searchFoodInteractor: SearchFoodInteractor) {
        self.view = view
        self.router = router
        self.searchFoodInteractor = searchFoodInteractor
    }
}

extension SearchPresenter: SearchPresentation {
    func viewDidLoad() {
        let model = NutritionModel()
        model.initializeDB()

        view?.updateTableView(data: model.dataSource)
    }

    func didSelectRow(food: Nutrition) {
        router.showDetailOf(food)
    }
}
