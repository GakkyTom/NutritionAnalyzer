//
//  Food.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/24.
//

import Foundation

struct Food: Decodable {
    var category: String
    var foodNumber: String
    var index: Int
    var foodName: String
    var nutritions: [Nutrition]

    func getNutritionValueOf(_ nutritionName: NutritionName) -> Float {
        return nutritions[nutritionName.rawValue].value
    }
}
