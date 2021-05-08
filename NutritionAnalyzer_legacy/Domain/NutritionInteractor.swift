//
//  NutritionInteractor.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/05/04.
//

import Foundation

protocol NutritionUsecase {
    func sumupBy(_ nutritionName: NutritionName) -> Double
    func getNutritionOf(_ foodId: Int) -> [Nutrition]?
}

class  NutritionInteractor {
    var helper = DatabaseHelper()
}

extension NutritionInteractor: NutritionUsecase {
    // ユーザーの栄養素のSumを返却する
    func sumupBy(_ nutritionName: NutritionName) -> Double {
        var result = 0.0
        helper.inDatabase { (db) in
            let rawSQL = """
                SELECT
                SUM(\(nutritionName.rawValue))
                FROM
                \(UserFoodTable.databaseTableName)
            """

            do {
                result = try Double.fetchAll(db, sql: rawSQL).first!
            } catch {
                // failしたらそのまま0.0を返す
            }
        }

        return result
    }

    func getNutritionOf(_ foodId: Int) -> [Nutrition]? {
        var nutritions: [Nutrition]?
        helper.inDatabase { (db) in
            let result = try FoodNutritionTable.filter(sql: "id = \(foodId)").fetchAll(db)
            result.forEach { res in
                let nutrition = Nutrition(nutritionName: res.nutritionName, nutritionValue: res.value)
                nutritions?.append(nutrition)
            }
        }

        return nutritions
    }
}
