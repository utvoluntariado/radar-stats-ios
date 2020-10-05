//
//  IntentMetricsSummary+Additions.swift
//  RadarSTATSIntents
//
//  Created by Pedro José Pereira Vieito on 3/10/20.
//

import Foundation
import Intents

extension IntentMetricsSummary {
    private static let displayName = "Metrics Summary"
    
    public static func createEmptySummary() -> IntentMetricsSummary {
        return IntentMetricsSummary(identifier: nil, display: Self.displayName)
    }
}

extension IntentMetricsSummary {
    public var usageRatio: Double {
        guard let sharedDiagnoses = self.sharedDiagnoses,
              let covidCases = self.covidCases else {
            return 0
        }
        return sharedDiagnoses.doubleValue / covidCases.doubleValue
    }
}

extension IntentMetricsSummary {
    private static let unknownDisplayString = "Unknown"
    
    public var extractionDate: Date? {
        guard let extractionTimestamp = self.extractionTimestamp,
              let extractionDate = Calendar.current.date(from: extractionTimestamp) else {
            return nil
        }
        return extractionDate
    }
    
    public var displayExtensionDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }
    
    public var displayExtractionDate: String {
        guard let extractionDate = self.extractionDate else {
            return Self.unknownDisplayString
        }
        return self.displayExtensionDateFormatter.string(from: extractionDate)
    }
    
    public var displayUploadedTEKs: String {
        let numberFormatter = NumberFormatter()
        guard let uploadedTEKs = self.uploadedTEKs,
              let displayUploadedTEKs = numberFormatter.string(from: uploadedTEKs) else {
            return Self.unknownDisplayString
        }
        return displayUploadedTEKs
    }
    
    public var displaySharedDiagnoses: String {
        let numberFormatter = NumberFormatter()
        guard let sharedDiagnoses = self.sharedDiagnoses,
              let displaySharedDiagnoses = numberFormatter.string(from: sharedDiagnoses) else {
            return Self.unknownDisplayString
        }
        return displaySharedDiagnoses
    }
    
    public var displayUsageRatio: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = 2
        guard let displayUsageRatio = numberFormatter.string(from: NSNumber(value: self.usageRatio)) else {
            return Self.unknownDisplayString
        }
        return displayUsageRatio
    }
}
