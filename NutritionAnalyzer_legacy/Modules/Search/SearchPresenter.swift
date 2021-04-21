//
//  SearchPresenter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol SearchPresentation: AnyObject {
    func viewDidLoad()
    func searchButtonTapped(_ foodName: String)
    func didSelectRow(food: Nutrition)
}

class SearchPresenter {
    private weak var view: SearchView?
    private let router: SearchWireframe
    private let searchFoodInteractor: SearchFoodInteractor
    private let searchModel: NutritionModel

    init(view: SearchView,
         router: SearchWireframe,
         searchFoodInteractor: SearchFoodInteractor,
         searchModel: NutritionModel) {
        self.view = view
        self.router = router
        self.searchFoodInteractor = searchFoodInteractor
        self.searchModel = searchModel
    }
}

extension SearchPresenter: SearchPresentation {
    func viewDidLoad() {
        searchModel.initializeDB()

        view?.updateTableView(data: searchModel.dataSource)
    }

    func searchButtonTapped(_ foodName: String) {
        let data = searchModel.getFoodBy(foodName)
        view?.updateTableView(data: data)
    }

    func didSelectRow(food: Nutrition) {
        router.showDetailOf(food)
    }
}
