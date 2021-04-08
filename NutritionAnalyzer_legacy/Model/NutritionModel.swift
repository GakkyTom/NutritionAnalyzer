//
//  NutritionModel.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/05.
//

import Foundation

class NutritionModel {
    var dataSource: [Nutrition] = []
    var userData: [Nutrition] = []

    func initializeDB() {
        let helper = DatabaseHelper()

        helper.createDatabase()
    }

    func refresh() {
        guard let data = try? getJSONData() else { return }
        dataSource = try! JSONDecoder().decode([Nutrition].self, from: data)
    }

    func getJSONData() throws -> Data? {
        guard let path = Bundle.main.path(forResource: "nutrition_labels_fact", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)

        return try Data(contentsOf: url)
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
        let helper = DatabaseHelper()

        helper.inDatabase { (db) in
            var entity = UserPFC(foodId: 0, foodName: "test", protein: 0.1, fat: 1.0, corbon: 0.8)
            try entity.insert(db)
        }
    }

    func fetch() {
        let helper = DatabaseHelper()
        var result: [UserPFC] = []

        helper.inDatabase { (db) in
            result = try UserPFC.fetchAll(db)
        }
        
        result.forEach { (item) in
            print("this is result: \(item.foodName)")
        }
    }
}
