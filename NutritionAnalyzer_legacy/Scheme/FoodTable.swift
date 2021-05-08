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
    var category: String
    var foodNumber: String
    var index: Int          // 他ではfoodIdと合致
    var foodName: String

    static var databaseTableName: String {
        return "tbl_food"
    }

    static func create(_ db: Database) throws {
        try db.create(table: databaseTableName, body: { (t: TableDefinition) in
            t.column("category", .integer).primaryKey()
            t.column("foodNumber", .integer).notNull()
            t.column("index", .text).notNull()
            t.column("foodName", .double).notNull()
        })
    }
}
