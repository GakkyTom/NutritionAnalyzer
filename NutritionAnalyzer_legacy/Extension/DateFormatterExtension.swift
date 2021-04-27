//
//  DateFormatterExtension.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/28.
//

import Foundation

extension DateFormatter {

    /// iPhoneの暦法にあったフォーマットを返却する
    func getLocalizedDateFormat(calendar: Calendar) -> Self {
        if calendar.isJapaneseCalendar() {
            self.locale = Locale(identifier: "ja")
            self.calendar = Calendar(identifier: .japanese)
            self.dateFormat = "Gy年M月d日"
        } else {
            self.dateFormat = "yyyy/MM/dd"
        }
        return self
    }
}
