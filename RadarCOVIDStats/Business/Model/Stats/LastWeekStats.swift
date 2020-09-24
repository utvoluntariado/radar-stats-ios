//
//  LastWeekStats.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import Foundation

struct LastWeekStats: Codable {
    let covidCases: Int
    let sharedTeksByUploadDate: Int
    let sharedDiagnoses: Int
    let teksPerSharedDiagnosis: Double
    let sharedDiagnosesPerCovidCase: Double
}
