//
//  HTTPClientError.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

enum HTTPClientError: LocalizedError, Equatable {
    case invalidBaseURL
    case notConfigured
    case invalidResponse
    case noData
    case invalidData
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidBaseURL: return "HTTPClient reports invalid baseUrl"
        case .notConfigured: return "HTTPClient is not configured."
        case .invalidResponse: return "HTTPClient reports invalid response."
        case .noData: return "HTTPClient reports there's no data to parse."
        case .invalidData: return "HTTPClient reports cannot parse data."
        case .unknown: return "HTTPClient reports unknown."
        }
    }
}

func == (lhs: HTTPClientError, rhs: HTTPClientError) -> Bool {
    return lhs.errorDescription == rhs.errorDescription
}

func == (lhs: LocalizedError, rhs: HTTPClientError) -> Bool {
    return lhs.errorDescription == rhs.errorDescription
}

func == (lhs: Error, rhs: HTTPClientError) -> Bool {
    return lhs.localizedDescription == rhs.errorDescription
}
