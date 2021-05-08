//
//  DetailPresenter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol DetailPresentation: AnyObject {
    func viewDidLoad()
    func addButtonTapped(foodDetail: FoodDetail, foodQt: Double, eatDate: Date)
    func calcButtonTapped(foodQt: Double)
}

class DetailPresenter {
    private weak var view: DetailView?
    private let router: DetailWireframe
    private let searchFoodInteractor: FoodUsecase
    private let foodId: Int

    init(view: DetailView,
         router: DetailWireframe,
         searchFoodInteractor: FoodUsecase,
         foodId: Int) {
        self.view = view
        self.router = router
        self.searchFoodInteractor = searchFoodInteractor
        self.foodId = foodId
    }
}

extension DetailPresenter: DetailPresentation {
    func viewDidLoad() {
        let foodDetail = searchFoodInteractor.getFoodDetailBy(foodId: foodId)
        view?.updateLabels(foodDetail: foodDetail)
        view?.updateData(foodDetail: foodDetail)
        view?.setupTableView()
        view?.setupKeyboard()
        view?.setupGestureRecognizer()
    }

    func addButtonTapped(foodDetail: FoodDetail, foodQt: Double, eatDate: Date) {
//        searchFoodInteractor.insert(foodDetail: foodDetail, foodQt: foodQt, eatDate: eatDate)
        view?.closeDetail()
    }

    func calcButtonTapped(foodQt: Double) {
//        let calcedNutritions = food.nutritions.map {
//            FoodNutrition(foodIndex: food.index, nutritionName: $0.nutritionName, value: $0.value * foodQt / 100)
//        }

//        view?.updateNutritions(nutritions: calcedNutritions)
    }
}
