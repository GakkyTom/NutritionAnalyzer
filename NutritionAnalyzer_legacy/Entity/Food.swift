//
//  Food.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/05/08.
//

import Foundation

struct Food : Codable {
    var foodId: Int
    var category: String
    var foodNumber: String
    var foodName: String
    var nutritions: [Nutrition]
}
