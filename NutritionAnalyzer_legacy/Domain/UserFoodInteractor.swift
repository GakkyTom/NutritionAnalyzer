//
//  NutritionStaticsInteractor.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol UserFoodUsecase: AnyObject {
    func fetchAll() -> [UserFood]
    func insert(foodDetail: FoodDetail, foodQt: Double, eatDate: Date)
    func isExistsUserFood() -> Bool
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

    // UserFoodへの登録
    func insert(foodDetail: FoodDetail, foodQt: Double, eatDate: Date) {
        helper.inDatabase { (db) in
            var entity = UserFoodTable(userFoodId: nil, foodId: foodDetail.foodId, foodName: foodDetail.foodName, foodQt: foodQt, eatDate: eatDate)
            try entity.insert(db)
        }
    }

    func isExistsUserFood() -> Bool {
        var result: [UserFoodTable] = []
        helper.inDatabase { (db) in
            result = try UserFoodTable.fetchAll(db)
        }

        return !result.isEmpty

    }
}
