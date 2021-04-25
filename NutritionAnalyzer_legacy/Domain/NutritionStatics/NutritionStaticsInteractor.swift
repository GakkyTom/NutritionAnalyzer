//
//  NutritionStaticsInteractor.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol NutritionStaticsUsecase: AnyObject {
    func fetch() -> [UserPFC]
    func sumup(_ target: String) -> Double
}

class NutritionStaticsInteractor {
    var helper = DatabaseHelper()
}

extension NutritionStaticsInteractor: NutritionStaticsUsecase {
    func fetch() -> [UserPFC] {
        var result: [UserPFC] = []

        helper.inDatabase { (db) in
            result = try UserPFC.fetchAll(db)
        }

        return result
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
