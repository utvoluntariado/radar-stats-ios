//
//  StatsRepositorys.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import Foundation
import PromiseKit

protocol StatsRepository {
    var httpClient: HTTPClient! { get set }
    var storageService: StorageService! { get set }

    func stats() -> Promise<Stats>
}

class StatsRepositoryDefault: StatsRepository {
    var httpClient: HTTPClient!
    var storageService: StorageService!

    func stats() -> Promise<Stats> {
        return Promise<Stats> { seal in
            httpClient.configure(using: .github)
            var request = HTTPRequest<Stats>(endpoint: API.GitHub.stats)
            httpClient.run(request: &request, { (result) in
                switch result {
                case .success(let result): seal.fulfill(result)
                case .failure(let error): seal.reject(error)
                }
            })
        }
    }
}
