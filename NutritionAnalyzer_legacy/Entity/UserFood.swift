//
//  UserPFC.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/08.
//

import GRDB

// ユーザの登録した食材
struct UserFood : Codable, FetchableRecord, MutablePersistableRecord {
    var userFoodId: Int     // 当UserFoodのID
    var foodId: Int         // 食材ID
    var foodName: String    // 食材名
    var foodQt: Double      // 食材の量（Quantity）
    var eatDate: Date       // 登録日付

    static var databaseTableName: String {
        return "tbl_user_food"
    }

    static func create(_ db: Database) throws {
        try db.create(table: databaseTableName, body: { (t: TableDefinition) in
            t.column("userFoodId", .integer).primaryKey()
            t.column("foodId", .integer).notNull()
            t.column("foodName", .text).notNull()
            t.column("foodQt", .double).notNull()
            t.column("eatDate", .date).notNull()
        })
    }
}
