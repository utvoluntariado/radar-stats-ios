//
//  IntentType.swift
//  RadarSTATSIntents
//
//  Created by Pedro José Pereira Vieito on 3/10/20.
//

import Foundation
import Intents

public enum IntentType: CaseIterable {
    case getMetricsSummary

    public var intentClass: AnyClass {
        switch self {
        case .getMetricsSummary:
            return GetMetricsSummaryIntent.self
        }
    }
}

extension IntentType {
    public init?(intent: INIntent) {
        for intentType in Self.allCases {
            if type(of: intent) === intentType.intentClass {
                self = intentType
                return
            }
        }
        return nil
    }
}
