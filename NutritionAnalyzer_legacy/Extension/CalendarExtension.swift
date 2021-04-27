//
//  CalendarExtension.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/28.
//

import Foundation

extension Calendar {
   func isJapaneseCalendar() -> Bool {
        return self.identifier == Calendar.Identifier.japanese
    }
}
