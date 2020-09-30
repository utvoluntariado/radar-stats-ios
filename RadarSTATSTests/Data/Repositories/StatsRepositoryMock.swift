//
//  StatsRepositoryMock.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 30/09/2020.
//

import Foundation
import PromiseKit

@testable import RadarCOVID_STATS

class StatsRepositoryMock: StatsRepositoryDefault {
    var shouldFail = false

    override func stats() -> Promise<Stats> {
        return Promise<Stats> { seal in
            if shouldFail {
                seal.reject(NetworkError.generic)
            } else {
                do {
                    let bundle = Bundle(for: type(of: self))
                    let jsonPath = bundle.path(forResource: "stats-mocked", ofType: "json")
                    let jsonData = try String(contentsOfFile: jsonPath!).data(using: .utf8)!
                    let content = try JSONDecoder().decode(Stats.self, from: jsonData)
                    seal.fulfill(content)
                } catch {
                    seal.reject(error)
                }
            }
        }
    }
}
