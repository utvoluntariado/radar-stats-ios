//
//  DailyStats.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

struct DailyStats: Codable {
    let sampleDate: TimeInterval
    let covidCases: Int
    let sharedTeksByGenerationDate: Int
    let sharedTeksByUploadDate: Int
    let sharedDiagnoses: Int
    let teksPerSharedDiagnosis: Double
    let sharedDiagnosesPerCovidCase: Double
}

extension DailyStats {
    func preparedUsageRatio() -> Double {
        let number = NSNumber(value: sharedDiagnosesPerCovidCase)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = 2
        let stringNumber = numberFormatter.string(from: number) ?? "NaN"
        return (numberFormatter.number(from: stringNumber) ?? NSNumber(0)).doubleValue * 100
    }

    func preparedTeksPerSharedDiagnosis() -> Double {
        let number = NSNumber(value: teksPerSharedDiagnosis)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        let stringNumber = numberFormatter.string(from: number) ?? "NaN"
        return (numberFormatter.number(from: stringNumber) ?? NSNumber(0)).doubleValue
    }

    func formattedTeksPerSharedDiagnosis() -> String {
        let number = NSNumber(value: teksPerSharedDiagnosis)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: number) ?? "NaN"
    }
}
