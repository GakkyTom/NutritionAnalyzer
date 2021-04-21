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

    let databaseFile = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//    private let databaseFile = NSHomeDirectory() + "/Documents/" + DB_FILE_NAME
    private var dbQueue: DatabaseQueue?

    /// データベースの操作
    func inDatabase(_ block: (Database) throws -> Void) -> Bool {
        do {
            // 初回実行時にデータベースファイルを生成する
            let dbQueue = try DatabaseQueue(path: self.databaseFile.path)
            try dbQueue.inDatabase(block)
        } catch let error {
            print("Database Error: \(error.localizedDescription)")
            return false
        }
        return true
    }

    func createDatabase() {
        let result = inDatabase { (db) in
            try UserPFC.create(db)
        }

        if !result {
            print("Creating DB has failed.")
        }
    }
}
