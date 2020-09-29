//
//  API.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on24/09/2020.
//

import Foundation

struct API {
    struct GitHub {
        static let stats = HTTPEndpoint(address: "/Data/Resources/Current/RadarCOVID-Report-Summary-Results.json", method: .GET, responseDecodingStrategy: .convertFromSnakeCase)
    }
}
