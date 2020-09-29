//
//  HTTPClientConfiguration.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

struct HTTPClientConfiguration {
    let baseURL: URL
}

enum HTTPClientStandardConfigurations {
    case github
}
