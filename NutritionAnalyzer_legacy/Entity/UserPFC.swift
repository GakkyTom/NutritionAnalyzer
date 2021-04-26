//
//  UserPFC.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/08.
//

import GRDB

struct UserPFC : Codable, FetchableRecord, MutablePersistableRecord {
    var foodId: Int
    var foodName: String
    var protein: Float
    var fat: Float
    var carbohydrate: Float
    var foodQt: Float
    var eatDate: Date

    static var databaseTableName: String {
        return "tbl_user_pfc"
    }

    static func create(_ db: Database) throws {
        try db.create(table: databaseTableName, body: { (t: TableDefinition) in
            t.column("foodId", .integer).primaryKey()
            t.column("foodName", .text).notNull()
            t.column("protein", .double).notNull()
            t.column("fat", .double).notNull()
            t.column("carbohydrate", .double).notNull()
            t.column("foodQt", .double).notNull()
            t.column("eatDate", .date).notNull()
        })
    }
}
