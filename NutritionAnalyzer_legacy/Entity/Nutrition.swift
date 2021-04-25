//
//  Nutrition.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/05.
//

import Foundation

struct Nutrition: Decodable {
    var nutritionName: String
    var value: Float

    init (nutritionName: String, value: Float) {
        self.nutritionName = nutritionName
        self.value = value
    }
}
