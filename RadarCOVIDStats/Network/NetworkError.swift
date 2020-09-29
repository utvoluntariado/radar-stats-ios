//
//  NetworkError.swift
//  RadarCOVID STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import Foundation

enum NetworkError: LocalizedError {
    case notReachable

    var errorDescription: String? {
        switch self {
        case .notReachable: return "No hay conexión a Internet"
        }
    }
}
