//
//  LastHourStats.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on24/09/2020.
//

import Foundation

struct LastHourStats: Codable {
    let sharedTeksByUploadDate: Int
    let sharedDiagnoses: Int
}
