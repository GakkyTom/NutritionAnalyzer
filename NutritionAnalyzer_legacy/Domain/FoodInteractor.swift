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
    func isExistsFoodData() -> Bool
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
                print("initializing food: \(food)")
                var foodEntity = FoodTable(foodId: food.foodId, category: food.category, foodNumber: food.foodNumber, foodName: food.foodName)

                try foodEntity.insert(db)

                try food.nutritions!.forEach { nutrition in

                    var nutritionEntity = FoodNutritionTable(foodId: food.foodId, nutritionName: nutrition.nutritionName, value: nutrition.value)
                    try nutritionEntity.insert(db)
                }
            }
        }
    }
}

extension FoodInteractor: FoodUsecase {
    func refresh() {
        guard let data = try? getJSONData() else { return }
        dataSource = try! JSONDecoder().decode([Food].self, from: data)

        if !isExistsFoodData() {
            initFoodTable()
        } else {
            print("db already exists")
        }
    }

    func getFoodBy(name: String) -> [Food] {
        var foods: [Food] = []
        helper.inDatabase { (db) in
            let result = try! FoodTable.filter(Column("foodName").like("%\(name)%")).fetchAll(db)
            result.forEach { (res) in
                let food = Food(foodId: res.foodId, category: res.category, foodNumber: res.foodNumber, foodName: res.foodName)
                foods.append(food)
            }
        }

        return foods
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


    func isExistsFoodData() -> Bool {
        var result: [FoodTable] = []
        helper.inDatabase { (db) in
            result = try FoodTable.fetchAll(db)
        }

        return !result.isEmpty
    }
}
