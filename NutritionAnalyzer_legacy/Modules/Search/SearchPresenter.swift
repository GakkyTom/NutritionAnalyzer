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
    func didSelectRow(foodId: Int)
}

class SearchPresenter {
    private weak var view: SearchView?
    private let router: SearchWireframe
    private let foodInteractor: FoodInteractor

    init(view: SearchView,
         router: SearchWireframe,
         foodInteractor: FoodInteractor) {
        self.view = view
        self.router = router
        self.foodInteractor = foodInteractor
    }
}

extension SearchPresenter: SearchPresentation {
    func viewDidLoad() {
        foodInteractor.refresh()

        view?.updateTableView(data: foodInteractor.dataSource)
    }

    func searchButtonTapped(_ foodName: String) {
        let data = foodInteractor.getFoodBy(name: foodName)
        view?.updateTableView(data: data)
    }

    func didSelectRow(foodId: Int) {
        router.showDetailOf(foodId)
    }
}
