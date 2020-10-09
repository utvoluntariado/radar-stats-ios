//
//  IntentHandler.swift
//  RadarSTATSIntentsExtension
//
//  Created by Pedro José Pereira Vieito on 4/10/20.
//

import Intents
import RadarSTATSIntents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any? {
        return IntentHandlerProvider.handler(for: intent)
    }
}
