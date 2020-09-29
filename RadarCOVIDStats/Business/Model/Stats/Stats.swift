//
//  Stats.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

struct Stats: Codable {
    let extractionDatetime: TimeInterval
    let lastHour: LastHourStats
    let today: TodayStats
    let last7Days: LastWeekStats
    let dailyResults: [DailyStats]
}

extension Stats {
    func formattedExtrationDate(style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = style
        formatter.timeStyle = .none
        let date = Date(timeIntervalSince1970: extractionDatetime / 1000)
        return formatter.string(from: date)
    }
}
