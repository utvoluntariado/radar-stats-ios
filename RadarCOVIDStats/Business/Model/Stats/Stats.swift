//
//  Stats.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import Foundation

struct Stats: Codable {
    let extractionDatetime: TimeInterval
    let lastHour: LastHourStats
    let today: TodayStats
    let last7Days: LastWeekStats
    let dailyResults: [DailyStats]
}
