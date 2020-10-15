//
//  GetMetricsSummaryIntent+Additions.swift
//  RadarSTATSIntents
//
//  Created by Pedro José Pereira Vieito on 3/10/20.
//

import Foundation
import Intents
import RadarSTATSKit

extension GetMetricsSummaryIntent {
    public func loadMetricsSummary() throws -> IntentMetricsSummary {
        let intentMetricsSummary = IntentMetricsSummary.createEmptySummary()
        let results = try RadarSTATSManager.loadResults()
        let metrics: RadarSTATSMetrics

        switch self.metricsPeriod {
        case .last7Days, .unknown:
            metrics = results.last7Days
        case .today:
            metrics = results.today
        }
        
        intentMetricsSummary.extractionTimestamp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: results.extractionDate)
        intentMetricsSummary.sharedDiagnoses = NSNumber(value: metrics.sharedDiagnoses)
        intentMetricsSummary.uploadedTEKs = NSNumber(value: metrics.sharedTeksByUploadDate)
        intentMetricsSummary.covidCases = NSNumber(value: metrics.covidCases)
        return intentMetricsSummary
    }
}

extension GetMetricsSummaryIntent {
    public var displayMetricsPeriod: String {
        switch self.metricsPeriod {
        case .last7Days, .unknown:
            return IntentHandlerProvider.localizedString("INTENTS_METRICS_PERIOD_LAST_7_DAYS")
        case .today:
            return IntentHandlerProvider.localizedString("INTENTS_METRICS_PERIOD_TODAY")
        }
    }
}
