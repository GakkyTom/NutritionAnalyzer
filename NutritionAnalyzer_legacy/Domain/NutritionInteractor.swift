//
//  NutritionInteractor.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/05/04.
//

import Foundation

protocol NutritionUsecase {
    func sumupBy(_ nutritionName: NutritionName) -> Double
}

class  NutritionInteractor {
    var helper = DatabaseHelper()
}

extension NutritionInteractor: NutritionUsecase {
    // 全部の栄養素のSumをUserNutrition型で返却する
    func sumupBy(_ nutritionName: NutritionName) -> Double {
        var result = 0.0
        helper.inDatabase { (db) in
            let rawSQL = """
                SELECT
                SUM(\(nutritionName.rawValue))
                FROM
                \(UserFood.databaseTableName)
            """

            do {
                result = try Double.fetchAll(db, sql: rawSQL).first!
            } catch {
                // failしたらそのまま0.0を返す
            }
        }

        return result
    }

    func getNutritionOf(_ foodId: Int) -> FoodNutrition? {
        var result: FoodNutrition?
        helper.inDatabase { (db) in
            result = try FoodNutrition.filter(sql: "id = \(foodId)").fetchOne(db)
        }

        return result
    }
}
