//
//  GetMetricsSummaryIntentHandler.swift
//  RadarSTATSIntents
//
//  Created by Pedro José Pereira Vieito on 3/10/20.
//

import Foundation
import Intents

class GetMetricsSummaryIntentHandler: NSObject, GetMetricsSummaryIntentHandling {
    func handle(intent: GetMetricsSummaryIntent, completion: @escaping (GetMetricsSummaryIntentResponse) -> Void) {
        do {
            let intentMetricsSummary = try intent.loadMetricsSummary()
            let response = GetMetricsSummaryIntentResponse(
                code: .success, userActivity: nil)
            response.metricsSummary = intentMetricsSummary
            completion(response)
        } catch {
            completion(.failureWithErrorDescription(error.localizedDescription))
        }
    }
}
