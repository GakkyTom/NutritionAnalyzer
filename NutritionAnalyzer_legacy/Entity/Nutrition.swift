//
//  Nutrition.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/05.
//

import Foundation

struct Nutrition: Decodable {
    var category: String
    var foodNumber: String
    var index: Int
    var foodName: String
    var disposalRate: Float
    var energy: Float
    var energyKcal: Float
    var water: Float
    var proteinAac: Float
    var protein: Float
    var cholesterol: Float
    var fat: Float
    var dietaryFiber: Float
    var sugarAlcohol: Float
    var carbohydrate: Float
    var organicAcid: Float
    var ash: Float
    var sodium: Float
    var potassium: Float
    var calcium: Float
    var magnesium: Float
    var phosphorus: Float
    var iron: Float
    var zinc: Float
    var copper: Float
    var manganese: Float
    var Iodine: Float
    var selenium: Float
    var chromium: Float
    var molybdenum: Float
    var retinol: Float
    var vitaminD: Float
    var vitaminE: Float
    var vitaminK: Float
    var vitaminB1: Float
    var vitaminB2: Float
    var niacin: Float
    var vitaminB6: Float
    var vitaminB12: Float
    var folicAcid: Float
    var pantothenicAcid: Float
    var biotin: Float
    var vitaminC: Float
    var alcohol: Float
    var sodiumChlorideEquivalent: Float
    var memo3: String?
}
