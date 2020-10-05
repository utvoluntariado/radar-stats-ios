//
//  IntentHandlerProvider.swift
//  RadarSTATSIntents
//
//  Created by Pedro José Pereira Vieito on 3/10/20.
//

import Foundation
import Intents

public class IntentHandlerProvider {
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

extension IntentHandlerProvider {
    private static var bundle: Bundle {
        return Bundle(for: IntentHandlerProvider.self)
    }
    
    internal static func localizedString(_ key: String) -> String {
        return Self.bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}
