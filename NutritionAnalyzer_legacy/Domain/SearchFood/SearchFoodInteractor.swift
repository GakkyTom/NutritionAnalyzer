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
    func getFoodBy(_ name: String) -> [Food]
    func add(food: Food)
    func insert(food: Food)
    func isExistsUserData() -> Bool
    func delete()
}

class SearchFoodInteractor {
    var dataSource: [Food] = []
    var userData: [Food] = []
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
        dataSource = try! JSONDecoder().decode([Food].self, from: data)
    }

    func getFoodBy(_ name: String) -> [Food] {
        dataSource.filter { (nutrition) -> Bool in
            nutrition.foodName.contains(name)
        }
    }

    func add(food: Food) {
        userData.append(food)
    }

    func insert(food: Food) {
        helper.inDatabase { (db) in
            var entity = UserPFC(food: food)
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

    func delete() {
        helper.inDatabase { (db) in
            try UserPFC.deleteAll(db)
        }
    }
}
