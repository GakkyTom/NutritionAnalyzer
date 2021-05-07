//
//  NutritionStaticsInteractor.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol UserFoodUsecase: AnyObject {
    func fetchAll() -> [UserFood]
}

class UserFoodInteractor {
    var helper = DatabaseHelper() // TODO: これBaseクラスに切ってもよいかも
}

extension UserFoodInteractor: UserFoodUsecase {
    func fetchAll() -> [UserFood] {
        var result: [UserFood] = []

        helper.inDatabase { (db) in
            result = try UserFood.fetchAll(db)  // 期間で絞る
        }

        return result
    }
}
