//
//  HTTPEnpoint.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

struct HTTPEndpoint: Equatable {
    private(set) var address: String
    private(set) var method: HTTPMethod
    private(set) var responseDecodingStrategy: JSONDecoder.KeyDecodingStrategy?
}

func == (lhs: HTTPEndpoint, rhs: HTTPEndpoint) -> Bool {
    return lhs.address == rhs.address && lhs.method == rhs.method
}
