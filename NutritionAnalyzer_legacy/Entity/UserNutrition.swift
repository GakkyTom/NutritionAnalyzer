//
//  UserNutrition.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/05/08.
//

import Foundation

// ホーム画面のユーザーの栄養リスト
struct UserNutrition {
    var nutritionId: Int        // 栄養詳細画面への遷移で使う
    var nutritionName: String
    var nutritionValue: Double
}
