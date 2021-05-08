//
//  NutritionStaticsInteractor.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol UserFoodUsecase: AnyObject {
    func fetchAll() -> [UserFood]
}

class UserFoodInteractor {
    var helper = DatabaseHelper() // TODO: これBaseクラスに切ってもよいかも
}

extension UserFoodInteractor: UserFoodUsecase {
    func fetchAll() -> [UserFood] {
        var userFoods: [UserFood] = []

        helper.inDatabase { (db) in
            let result = try UserFoodTable.fetchAll(db)  // 期間で絞る
            result.forEach { res in
                let userFood = UserFood(foodName: res.foodName, eatDate: res.eatDate, foodQt: res.foodQt)
                userFoods.append(userFood)
            }
        }

        return userFoods
    }
}
