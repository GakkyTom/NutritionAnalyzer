//
//  NutritionName.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/25.
//

import Foundation

enum NutritionName: String, CaseIterable {
    case disposalRate
    case energy
    case energyKcal
    case water
    case proteinAac
    case protein
    case cholesterol
    case fat
    case dietaryFiber
    case sugarAlcohol
    case carbohydrate
    case organicAcid
    case ash
    case sodium
    case potassium
    case calcium
    case magnesium
    case phosphorus
    case iron
    case zinc
    case copper
    case manganese
    case Iodine
    case selenium
    case chromium
    case molybdenum
    case retinol
    case vitaminD
    case vitaminE
    case vitaminK
    case vitaminB1
    case vitaminB2
    case niacin
    case vitaminB6
    case vitaminB12
    case folicAcid
    case pantothenicAcid
    case biotin
    case vitaminC
    case alcohol
    case sodiumChlorideEquivalent
    case memo3

    var id: Int {
        switch self {
        case .disposalRate: return 0
        case .energy: return 1
        case .energyKcal: return 2
        case .water: return 3
        case .proteinAac: return 4
        case .protein: return 5
        case .cholesterol: return 6
        case .fat: return 7
        case .dietaryFiber: return 8
        case .sugarAlcohol: return 9
        case .carbohydrate: return 10
        case .organicAcid: return 11
        case .ash: return 12
        case .sodium: return 13
        case .potassium: return 14
        case .calcium: return 15
        case .magnesium: return 16
        case .phosphorus: return 17
        case .iron: return 18
        case .zinc: return 19
        case .copper: return 20
        case .manganese: return 21
        case .Iodine: return 22
        case .selenium: return 23
        case .chromium: return 24
        case .molybdenum: return 25
        case .retinol: return 26
        case .vitaminD: return 27
        case .vitaminE: return 28
        case .vitaminK: return 29
        case .vitaminB1: return 30
        case .vitaminB2: return 31
        case .niacin: return 32
        case .vitaminB6: return 33
        case .vitaminB12: return 34
        case .folicAcid: return 35
        case .pantothenicAcid: return 36
        case .biotin: return 37
        case .vitaminC: return 38
        case .alcohol: return 39
        case .sodiumChlorideEquivalent: return 40
        case .memo3: return 41
        }
    }
}
