//
//  LocalizationsRepository.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 01/10/2020.
//

import Foundation
import PromiseKit

protocol LocalizationRepository {
    func localizations() -> Promise<Localization>
}

class LocalizationRepositoryDefault: LocalizationRepository {
    func localizations() -> Promise<Localization> {
        return Promise<Localization> { seal in
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
