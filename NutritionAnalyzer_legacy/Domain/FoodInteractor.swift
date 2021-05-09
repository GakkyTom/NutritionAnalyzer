//
//  FoodInteractor.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/21.
//

import Foundation
import GRDB

protocol FoodUsecase: AnyObject {
    func refresh()
    func getFoodBy(name: String) -> [Food]
    func getFoodDetailBy(foodId: Int) -> FoodDetail?
    func add(food: Food)
    func insert(foodDetail: FoodDetail, foodQt: Double, eatDate: Date)
    func isExistsFoodData() -> Bool
    func delete()
}

class FoodInteractor {
    var dataSource: [Food] = []
    var userData: [Food] = []
    var helper = DatabaseHelper()

    private func getJSONData() throws -> Data? {
        guard let path = Bundle.main.path(forResource: "nutrition_fact", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)

        return try Data(contentsOf: url)
    }

    private func initFoodTable() {
        dataSource.forEach { food in
            helper.inDatabase { (db) in
                var foodEntity = FoodTable(foodId: food.foodId, category: food.category, foodNumber: food.foodNumber, foodName: food.foodName)

                try foodEntity.insert(db)

                try food.nutritions.forEach { nutrition in
                    var nutritionEntity = FoodNutritionTable(foodId: food.foodId, nutritionName: nutrition.nutritionName, value: nutrition.value)
                    try nutritionEntity.insert(db)
                }
            }
        }
    }
}

extension FoodInteractor: FoodUsecase {
    func refresh() {
        self.delete()

        guard let data = try? getJSONData() else { return }
        dataSource = try! JSONDecoder().decode([Food].self, from: data)

        if !isExistsFoodData() {
            initFoodTable()
        }
    }

    func getFoodBy(name: String) -> [Food] {
        dataSource.filter { (nutrition) -> Bool in
            nutrition.foodName.contains(name)
        }
    }

    func getFoodDetailBy(foodId: Int) -> FoodDetail? {
        var result: FoodDetail?
        helper.inDatabase { (db) in
            let food = try! FoodTable.filter(sql: "foodId = \(foodId)").fetchAll(db)

            let foodName = food[0].foodName

            let foodDetail = try FoodNutritionTable.filter(sql: "foodId = \(foodId)").fetchAll(db)

            var nutritions: [Nutrition] = []
            foodDetail.forEach { res in
                let nutrition = Nutrition(foodId: res.foodId, nutritionName: res.nutritionName, value: res.value)
                nutritions.append(nutrition)
            }

            result = FoodDetail(foodId: foodId, foodName: foodName, nutritions: nutritions)
        }

        return result
    }

    func add(food: Food) {
        userData.append(food)
    }

    // UserFoodへの登録
    func insert(foodDetail: FoodDetail, foodQt: Double, eatDate: Date) {
        helper.inDatabase { (db) in
            var entity = UserFoodTable(userFoodId: nil, foodId: foodDetail.foodId, foodName: foodDetail.foodName, foodQt: foodQt, eatDate: eatDate)
            try entity.insert(db)
        }
    }

    func isExistsFoodData() -> Bool {
        var result: [FoodTable] = []
        helper.inDatabase { (db) in
            result = try FoodTable.fetchAll(db)
        }

        return !result.isEmpty
    }

    func delete() {
        helper.inDatabase { (db) in
            try UserFoodTable.deleteAll(db)
        }
    }
}
