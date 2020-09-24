//
//  HourlyStats.swift
//  RadarCOVIDStats
//
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

struct LocallyStoredStats: Codable {
    let date: Date
    let stats: Stats
}
