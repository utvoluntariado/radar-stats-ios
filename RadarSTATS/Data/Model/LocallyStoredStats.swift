//
//  LocallyStoredStats.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

struct LocallyStoredStats: Codable {
    let date: Date
    let stats: Stats
}
