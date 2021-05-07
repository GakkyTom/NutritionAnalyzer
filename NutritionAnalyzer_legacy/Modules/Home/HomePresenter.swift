//
//  HomePresenter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol HomePresentation: AnyObject {
    func viewDidLoad()
    func refreshView(periodStart: Date)
    func getUserNutrition() -> [Nutrition]
    func getUserNutritionOf(_ index: Int) -> Nutrition
}

class HomePresenter {
    private weak var view: HomeView?

    private let router: HomeWireframe
    private let nutritionInteractor: NutritionUsecase
    private let userFoodInteractor: UserFoodUsecase

    init(view: HomeView,
         router: HomeWireframe,
         nutritionInteractor: NutritionUsecase,
         userFoodInteractor: UserFoodUsecase) {
        self.view = view
        self.router = router
        self.nutritionInteractor = nutritionInteractor
        self.userFoodInteractor = userFoodInteractor
    }
}

extension HomePresenter: HomePresentation {
    func viewDidLoad() {
        // Start with today's date
        self.refreshView(periodStart: Date())
        view?.setupDatePicker()
    }

    func refreshView(periodStart: Date) {
        let dateFormatter = DateFormatter().getLocalizedDateFormat(calendar: Calendar.current)
        // display one week (7days)
        let periodEnd = Calendar.current.date(byAdding: .day, value: 7, to: periodStart)!
        let periodString = "\(dateFormatter.string(from: periodStart)) to \(dateFormatter.string(from: periodEnd))"

        view?.setupLabels(periodLabel: periodString)
    }

    func getUserNutrition() -> [Nutrition] {
        var nutritions: [Nutrition] = []
        NutritionName.allCases.forEach { nutritionName in
            let nutritionValue = nutritionInteractor.sumupBy(nutritionName)
            let nutrition = Nutrition(nutritionName: nutritionName.rawValue, value: nutritionValue)
            nutritions.append(nutrition)
        }

        return nutritions
    }

    func getUserNutritionOf(_ index: Int) -> Nutrition {
        let nutrition = getUserNutrition()
        return nutrition[index]
    }
}
