//
//  FoodTable.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/24.
//

import Foundation
import GRDB

// 食材のテーブル定義
struct FoodTable: Codable, FetchableRecord, MutablePersistableRecord {
    var foodId: Int
    var category: String
    var foodNumber: String
    var foodName: String

    static var databaseTableName: String {
        return "tbl_food"
    }

    static func create(_ db: Database) throws {
        try db.create(table: databaseTableName, body: { (t: TableDefinition) in
            t.column("foodId", .integer).primaryKey()
            t.column("category", .text).notNull()
            t.column("foodNumber", .text).notNull()
            t.column("foodName", .text).notNull()
        })
    }
}
