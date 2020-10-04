//
//  StatsRepositoryMock.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 30/09/2020.
//

import Foundation
import PromiseKit

@testable import Radar_STATS

class StatsRepositoryMock: StatsRepositoryDefault {
    var shouldFail = false

    override func stats() -> Promise<(stats: Stats, shouldForceUpdate: Bool)> {
        return Promise<(stats: Stats, shouldForceUpdate: Bool)> { seal in
            if shouldFail {
                seal.reject(NetworkError.generic)
            } else {
                do {
                    let bundle = Bundle(for: type(of: self))
                    let jsonPath = bundle.path(forResource: "stats-mocked", ofType: "json")
                    let jsonData = try String(contentsOfFile: jsonPath!).data(using: .utf8)!
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = API.GitHub.stats.responseDecodingStrategy ?? .useDefaultKeys
                    let content = try decoder.decode(Stats.self, from: jsonData)
                    seal.fulfill((stats: content, shouldForceUpdate: false))
                } catch {
                    seal.reject(error)
                }
            }
        }
    }
}
