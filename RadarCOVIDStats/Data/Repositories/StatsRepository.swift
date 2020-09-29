//
//  StatsRepositorys.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation
import PromiseKit

protocol StatsRepository {
    var httpClient: HTTPClient! { get set }
    var storageService: StorageService! { get set }
    var networkService: NetworkService! { get set }

    func stats() -> Promise<Stats>
}

class StatsRepositoryDefault: StatsRepository {
    var httpClient: HTTPClient!
    var storageService: StorageService!
    var networkService: NetworkService!

    func stats() -> Promise<Stats> {
        return Promise<Stats> { seal in
            if let storedStats = validLocallyStoredStats() {
                seal.fulfill(storedStats.stats)
            } else if networkService.isReachable {
                httpClient.configure(using: .github)
                var request = HTTPRequest<Stats>(endpoint: API.GitHub.stats)
                httpClient.run(request: &request, { (result) in
                    switch result {
                    case .success(let result):
                        self.locallyStore(stats: result)
                        seal.fulfill(result)

                    case .failure(let error):
                        seal.reject(error)
                    }
                })
            } else {
                seal.reject(NetworkError.notReachable)
            }
        }
    }

    private func validLocallyStoredStats() -> LocallyStoredStats? {
        guard let storedStats: LocallyStoredStats = storageService.retrieve(from: .defaults(key: StorageKey.UserDefaults.hourlyStats)) else { return nil }
        guard let diff = Calendar.current.dateComponents([.hour], from: storedStats.date, to: Date()).hour else { return nil }
        return diff < 1 ? storedStats : nil
    }

    private func locallyStore(stats: Stats) {
        let localStats = LocallyStoredStats(date: Date(), stats: stats)
        try? self.storageService.store(item: localStats, on: .defaults(key: StorageKey.UserDefaults.hourlyStats))
    }
}
