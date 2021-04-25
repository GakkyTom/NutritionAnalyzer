//
//  DetailPresenter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol DetailPresentation: AnyObject {
    func viewDidLoad()
    func addButtonTapped()
    func calcButtonTapped()
}

class DetailPresenter {
    private weak var view: DetailView?
    private let router: DetailWireframe
    private let searchFoodInteractor: SearchFoodUsecase
    private let food: Food

    init(view: DetailView,
         router: DetailWireframe,
         searchFoodInteractor: SearchFoodUsecase,
         food: Food) {
        self.view = view
        self.router = router
        self.searchFoodInteractor = searchFoodInteractor
        self.food = food
    }
}

extension DetailPresenter: DetailPresentation {
    func viewDidLoad() {
        view?.updateLabels(food: food)
        view?.updateData(food: food)
    }

    func addButtonTapped() {
        searchFoodInteractor.insert(food: food)
        view?.closeDetail()
    }

    func calcButtonTapped() {
        view?.calcNutrition()
    }
}
