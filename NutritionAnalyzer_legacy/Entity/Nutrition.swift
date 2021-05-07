//
//  Nutrition.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/05/07.
//

import Foundation

// Home画面表示用のStruct
struct Nutrition {
    var nutritionName: String
    var value: Double

    init (nutritionName: String, value: Double) {
        self.nutritionName = nutritionName
        self.value = value
    }
}
