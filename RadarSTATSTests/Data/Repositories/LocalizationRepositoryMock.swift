//
//  LocalizationRepositoryMock.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 02/10/2020.
//

import Foundation
import PromiseKit

@testable import Radar_STATS

class LocalizationRepositoryMock: LocalizationRepositoryDefault {
    var shouldFail = false

    override func localizations() -> Promise<Localization> {
        return Promise<Localization> { seal in
            if shouldFail {
                seal.reject(NetworkError.generic)
            } else {
                do {
                    let jsonPath = Bundle.main.path(forResource: "localization", ofType: "json")
                    let jsonData = try String(contentsOfFile: jsonPath!).data(using: .utf8)!
                    let content = try JSONDecoder().decode(Localization.self, from: jsonData)
                    seal.fulfill(content)
                } catch {
                    seal.reject(error)
                }
            }
        }
    }
}
