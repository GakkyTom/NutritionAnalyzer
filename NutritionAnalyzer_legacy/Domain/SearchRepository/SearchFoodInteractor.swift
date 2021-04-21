//
//  SearchFoodInteractor.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/21.
//

import Foundation

protocol SearchFoodUsecase: AnyObject {
    func initializeDB()
    func refresh()
    func getFoodBy(_ name: String) -> [Nutrition]
    func add(food: Nutrition)
    func create()
    func insert(nutrition: Nutrition)
    func isExistsUserData() -> Bool
    func fetch()
    func delete()
    func sumup(_ target: String) -> Double
}

class SearchFoodInteractor {
    var dataSource: [Nutrition] = []
    var userData: [Nutrition] = []
    var helper = DatabaseHelper()

    private func getJSONData() throws -> Data? {
        guard let path = Bundle.main.path(forResource: "nutrition_labels_fact", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)

        return try Data(contentsOf: url)
    }

}

extension SearchFoodInteractor: SearchFoodUsecase {
    func initializeDB() {
        refresh()
        helper.createDatabase()

        self.delete()
    }

    func refresh() {
        guard let data = try? getJSONData() else { return }
        dataSource = try! JSONDecoder().decode([Nutrition].self, from: data)
    }

    func getFoodBy(_ name: String) -> [Nutrition] {
        dataSource.filter { (nutrition) -> Bool in
            nutrition.foodName.contains(name)
        }
    }

    func add(food: Nutrition) {
        userData.append(food)
    }

    func create() {
        helper.inDatabase { (db) in
            var entity = UserPFC(foodId: 0, foodName: "test", protein: 0.1, fat: 1.0, carbohydrate: 0.8)
            try entity.insert(db)
        }
    }

    func insert(nutrition: Nutrition) {
        helper.inDatabase { (db) in
            var entity = UserPFC(foodId: nutrition.index, foodName: nutrition.foodName, protein: nutrition.protein, fat: nutrition.fat, carbohydrate: nutrition.carbohydrate)
            try entity.insert(db)
        }
    }

    func isExistsUserData() -> Bool {
        var result: [UserPFC] = []
        helper.inDatabase { (db) in
            result = try UserPFC.fetchAll(db)
        }

        return !result.isEmpty
    }

    func fetch() {
        var result: [UserPFC] = []

        helper.inDatabase { (db) in
            result = try UserPFC.fetchAll(db)
        }

        result.forEach { (item) in
            print("this is result: \(item.foodName)")
        }
    }

    func delete() {
        helper.inDatabase { (db) in
            try UserPFC.deleteAll(db)
        }
    }

    func sumup(_ target: String) -> Double {
        var result = 0.0
        helper.inDatabase { (db) in
            let rawSQL = """
                SELECT
                SUM(\(target))
                FROM
                \(UserPFC.databaseTableName)
            """

            do {
                result = try Double.fetchAll(db, sql: rawSQL).first!
            } catch {
            }
        }

        return result
    }
}
