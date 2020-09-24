//
//  Stats.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import Foundation

struct LastHourStats: Codable {
    let sharedTeksByUploadDate: Int
    let sharedDiagnoses: Int
}
