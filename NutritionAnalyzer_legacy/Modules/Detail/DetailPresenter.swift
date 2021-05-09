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
    private let foodInteractor: FoodUsecase
    private let userFoodInteractor: UserFoodInteractor
    private let foodId: Int

    init(view: DetailView,
         router: DetailWireframe,
         foodInteractor: FoodUsecase,
         userFoodInteractor: UserFoodInteractor,
         foodId: Int) {
        self.view = view
        self.router = router
        self.foodInteractor = foodInteractor
        self.userFoodInteractor = userFoodInteractor
        self.foodId = foodId
    }
}

extension DetailPresenter: DetailPresentation {
    func viewDidLoad() {
        guard let foodDetail = foodInteractor.getFoodDetailBy(foodId: foodId as Int) else { return }
        
        view?.updateLabels(foodDetail: foodDetail)
        view?.updateData(foodDetail: foodDetail)
        view?.setupTableView()
        view?.updateNutritions(nutritions: foodDetail.nutritions)
        view?.setupKeyboard()
        view?.setupGestureRecognizer()
    }

    func addButtonTapped(foodDetail: FoodDetail, foodQt: Double, eatDate: Date) {
        userFoodInteractor.insert(foodDetail: foodDetail, foodQt: foodQt, eatDate: eatDate)
        view?.closeDetail()
    }

    func calcButtonTapped(foodQt: Double) {
//        let calcedNutritions = food.nutritions.map {
//            FoodNutrition(foodIndex: food.index, nutritionName: $0.nutritionName, value: $0.value * foodQt / 100)
//        }

//        view?.updateNutritions(nutritions: calcedNutritions)
    }
}
