//
//  TodayStats.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

struct TodayStats: Codable {
    let covidCases: Int
    let sharedTeksByUploadDate: Int
    let sharedDiagnoses: Int
    let teksPerSharedDiagnosis: Double
    let sharedDiagnosesPerCovidCase: Double
}

extension TodayStats {
    func formattedUsageRatio() -> String {
        let number = NSNumber(value: sharedDiagnosesPerCovidCase)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: number) ?? "NaN"
    }

    func formattedTeksPerSharedDiagnosis() -> String {
        let number = NSNumber(value: teksPerSharedDiagnosis)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: number) ?? "NaN"
    }
}
