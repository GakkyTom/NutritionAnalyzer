//
//  SearchFoodInteractor.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/21.
//

import Foundation

protocol FoodUsecase: AnyObject {
    func refresh()
    func getFoodBy(name: String) -> [Food]
    func getFoodDetailBy(foodId: Int) -> FoodDetail
    func add(food: Food)
    func insert(food: Food, foodQt: Double, eatDate: Date)
    func isExistsUserData() -> Bool
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
}

extension FoodInteractor: FoodUsecase {
    func refresh() {
        self.delete()

        guard let data = try? getJSONData() else { return }
        dataSource = try! JSONDecoder().decode([Food].self, from: data)
    }

    func getFoodBy(name: String) -> [Food] {
        dataSource.filter { (nutrition) -> Bool in
            nutrition.foodName.contains(name)
        }
    }

    // TODO: ダミー返しているので後で修正
    func getFoodDetailBy(foodId: Int) -> FoodDetail {
        return FoodDetail(foodName: "Test", nutritions: [Nutrition(nutritionName: "test nutrition", nutritionValue: 0.0)])
    }

    func add(food: Food) {
        userData.append(food)
    }

    func insert(food: Food, foodQt: Double, eatDate: Date) {
//        helper.inDatabase { (db) in
//            var entity = createUserPFC(food: food, foodQt: foodQt, eatDate: eatDate)
//            try entity.insert(db)
//        }
    }

    func isExistsUserData() -> Bool {
        var result: [UserFoodTable] = []
        helper.inDatabase { (db) in
            result = try UserFoodTable.fetchAll(db)
        }

        return !result.isEmpty
    }

    func delete() {
        helper.inDatabase { (db) in
            try UserFoodTable.deleteAll(db)
        }
    }

//    private func createUserPFC(food: Food, foodQt: Double, eatDate: Date) -> UserFood {
//        return UserFood(foodId: food.index,
//                       foodName: food.foodName,
//                       protein: food.getNutritionValueOf(.protein),
//                       fat: food.getNutritionValueOf(.fat),
//                       carbohydrate: food.getNutritionValueOf(.carbohydrate),
//                       foodQt: foodQt,
//                       eatDate: eatDate)
//    }
}
