//
//  FoodNutritionTable.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/05.
//

import GRDB

// 食材に紐づく栄養素マスタテーブル定義
struct FoodNutritionTable : Codable, FetchableRecord, MutablePersistableRecord {
    var foodId: Int
    var nutritionName: String
    var value: Double

    static var databaseTableName: String {
        return "tbl_food"
    }

    static func create(_ db: Database) throws {
        try db.create(table: databaseTableName, body: { (t: TableDefinition) in
            t.column("foodId", .integer).primaryKey(onConflict: .replace, autoincrement: false)
            t.column("nutritionName", .integer).notNull()
            t.column("value", .text).notNull()
        })
    }
}
