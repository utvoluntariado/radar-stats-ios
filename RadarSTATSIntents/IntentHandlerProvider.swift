//
//  IntentHandlerProvider.swift
//  RadarSTATSIntents
//
//  Created by Pedro José Pereira Vieito on 3/10/20.
//

import Foundation
import Intents

public struct IntentHandlerProvider {
    public static func handler(for intent: INIntent) -> Any? {
        guard let intentType = IntentType(intent: intent) else {
            return nil
        }
        
        switch intentType {
        case .getMetricsSummary:
            return GetMetricsSummaryIntentHandler()
        }
    }
}
