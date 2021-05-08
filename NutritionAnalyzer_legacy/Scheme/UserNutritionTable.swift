//
//  UserNutritionTable.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/05/05.
//

import Foundation
import GRDB

// ユーザの登録した食材に紐づく栄養
struct UserNutritionTable : Codable, FetchableRecord, MutablePersistableRecord {
    var userNutritionId: Int    // 当UserNutritionのID
    var userFoodId: Int         // 親であるUserFoodのID
    var nutritionId: Int
    var value: Double
//    var disposalRate: Double
//    var energy: Double
//    var energyKcal: Double
//    var water: Double
//    var proteinAac: Double
//    var protein: Double
//    var cholesterol: Double
//    var fat: Double
//    var dietaryFiber: Double
//    var sugarAlcohol: Double
//    var carbohydrate: Double
//    var organicAcid: Double
//    var ash: Double
//    var sodium: Double
//    var potassium: Double
//    var calcium: Double
//    var magnesium: Double
//    var phosphorus: Double
//    var iron: Double
//    var zinc: Double
//    var copper: Double
//    var manganese: Double
//    var Iodine: Double
//    var selenium: Double
//    var chromium: Double
//    var molybdenum: Double
//    var retinol: Double
//    var vitaminD: Double
//    var vitaminE: Double
//    var vitaminK: Double
//    var vitaminB1: Double
//    var vitaminB2: Double
//    var niacin: Double
//    var vitaminB6: Double
//    var vitaminB12: Double
//    var folicAcid: Double
//    var pantothenicAcid: Double
//    var biotin: Double
//    var vitaminC: Double
//    var alcohol: Double
//    var sodiumChlorideEquivalent: Double
//    var memo3: String

    static var databaseTableName: String {
        return "tbl_user_nutrition"
    }

    static func create(_ db: Database) throws {
        try db.create(table: databaseTableName, body: { (t: TableDefinition) in
            t.column("userNutritionId", .integer).primaryKey()
            t.column("userFoodId", .integer).notNull()
            t.column("nutritionId", .integer).notNull()
            t.column("value", .double).notNull()
            
//            t.column("disposalRate", .double).notNull()
//            t.column("energy", .double).notNull()
//            t.column("energyKcal", .double).notNull()
//            t.column("water", .double).notNull()
//            t.column("proteinAac", .double).notNull()
//            t.column("protein", .double).notNull()
//            t.column("cholesterol", .double).notNull()
//            t.column("fat", .double).notNull()
//            t.column("dietaryFiber", .double).notNull()
//            t.column("sugarAlcohol", .double).notNull()
//            t.column("carbohydrate", .double).notNull()
//            t.column("organicAcid", .double).notNull()
//            t.column("ash", .double).notNull()
//            t.column("sodium", .double).notNull()
//            t.column("potassium", .double).notNull()
//            t.column("calcium", .double).notNull()
//            t.column("magnesium", .double).notNull()
//            t.column("phosphorus", .double).notNull()
//            t.column("iron", .double).notNull()
//            t.column("zinc", .double).notNull()
//            t.column("copper", .double).notNull()
//            t.column("manganese", .double).notNull()
//            t.column("Iodine", .double).notNull()
//            t.column("selenium", .double).notNull()
//            t.column("chromium", .double).notNull()
//            t.column("molybdenum", .double).notNull()
//            t.column("retinol", .double).notNull()
//            t.column("vitaminD", .double).notNull()
//            t.column("vitaminE", .double).notNull()
//            t.column("vitaminK", .double).notNull()
//            t.column("vitaminB1", .double).notNull()
//            t.column("vitaminB2", .double).notNull()
//            t.column("niacin", .double).notNull()
//            t.column("vitaminB6", .double).notNull()
//            t.column("vitaminB12", .double).notNull()
//            t.column("folicAcid", .double).notNull()
//            t.column("pantothenicAcid", .double).notNull()
//            t.column("biotin", .double).notNull()
//            t.column("vitaminC", .double).notNull()
//            t.column("alcohol", .double).notNull()
//            t.column("sodiumChlorideEquivalent", .double).notNull()
//            t.column("memo3", .double).notNull()
        })
    }
}
