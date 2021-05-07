//
//  DetailPresenter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol DetailPresentation: AnyObject {
    func viewDidLoad()
    func addButtonTapped(food: Food, foodQt: Double, eatDate: Date)
    func calcButtonTapped(foodQt: Double)
}

class DetailPresenter {
    private weak var view: DetailView?
    private let router: DetailWireframe
    private let searchFoodInteractor: FoodUsecase
    private let food: Food
    private var calcedFood: Food

    init(view: DetailView,
         router: DetailWireframe,
         searchFoodInteractor: FoodUsecase,
         food: Food) {
        self.view = view
        self.router = router
        self.searchFoodInteractor = searchFoodInteractor
        self.food = food
        self.calcedFood = food
    }
}

extension DetailPresenter: DetailPresentation {
    func viewDidLoad() {
        view?.updateLabels(food: food)
        view?.updateData(food: food)
        view?.setupTableView()
        view?.setupKeyboard()
        view?.setupGestureRecognizer()
    }

    func addButtonTapped(food: Food, foodQt: Double, eatDate: Date) {
        searchFoodInteractor.insert(food: food, foodQt: foodQt, eatDate: eatDate)
        view?.closeDetail()
    }

    func calcButtonTapped(foodQt: Double) {
        let calcedNutritions = food.nutritions.map {
            FoodNutrition(foodIndex: food.index, nutritionName: $0.nutritionName, value: $0.value * foodQt / 100)
        }

        view?.updateNutritions(nutritions: calcedNutritions)
    }
}
