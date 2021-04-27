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
    func fetchUserData() -> [UserPFC]
    func sumup(_ target: NutritionName) -> Double
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
    func viewDidLoad() {
        // 初期表示は今日日付で初期化
        self.refreshView(periodStart: Date())
        view?.setupDatePicker()
    }

    func refreshView(periodStart: Date) {
        let dateFormatter = DateFormatter().getLocalizedDateFormat(calendar: Calendar.current)
        let periodEnd = Calendar.current.date(byAdding: .day, value: 7, to: periodStart)!
        let periodString = "\(dateFormatter.string(from: periodStart)) 〜 \(dateFormatter.string(from: periodEnd))"

        view?.setupLabels(periodLabel: periodString)
    }

    func fetchUserData() -> [UserPFC] {
        return nutritionStaticsInteractor.fetch()
    }

    func sumup(_ target: NutritionName) -> Double {
        return nutritionStaticsInteractor.sumup(target)
    }
}
