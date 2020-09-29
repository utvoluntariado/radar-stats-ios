//
//  StatsRepositorys.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on24/09/2020.
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
            if let storedStats: LocallyStoredStats = storageService.retrieve(from: .defaults(key: StorageKey.UserDefaults.hourlyStats)),
               let diff = Calendar.current.dateComponents([.hour], from: storedStats.date, to: Date()).hour,
               diff < 1 {
                    seal.fulfill(storedStats.stats)
            } else {
                httpClient.configure(using: .github)
                var request = HTTPRequest<Stats>(endpoint: API.GitHub.stats)
                httpClient.run(request: &request, { (result) in
                    switch result {
                    case .success(let result):
                        let localStats = LocallyStoredStats(date: Date(), stats: result)
                        try? self.storageService.store(item: localStats, on: .defaults(key: StorageKey.UserDefaults.hourlyStats))
                        seal.fulfill(result)

                    case .failure(let error):
                        seal.reject(error)
                    }
                })
            }
        }
    }
}
