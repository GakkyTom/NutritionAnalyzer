//
//  DatabaseHelper.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/08.
//

import Foundation
import GRDB

class DatabaseHelper {
    static let DB_FILE_NAME = "nutrition_analyzer.db"

    let databaseFile = NSTemporaryDirectory() + "database.db"
    private var dbQueue: DatabaseQueue?

    /// データベースの操作
    @discardableResult
    func inDatabase(_ block: (Database) throws -> Void) -> Bool {
        do {
            // 初回実行時にデータベースファイルを生成する
            let dbQueue = try DatabaseQueue(path: self.databaseFile)
            try dbQueue.inDatabase(block)
        } catch let error {
            print("Database Error: \(error.localizedDescription)")
            return false
        }
        return true
    }

    func createDatabase() {
        let result = inDatabase { (db) in
            try FoodTable.create(db)
            try FoodNutritionTable.create(db)
            try UserNutritionTable.create(db)
            try UserFoodTable.create(db)
        }

        if !result {
            print("Creating DB has failed.")
        }
    }
}
