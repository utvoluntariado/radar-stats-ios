//
//  Localization.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 01/10/2020.
//

import Foundation

struct Localization: Codable {
    var definitions: BasicDefinition
    var charts: [LocalizationItem]
}

