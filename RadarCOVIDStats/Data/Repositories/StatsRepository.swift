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

    func stats() -> Promise<Stats>
}

class StatsRepositoryDefault: StatsRepository {
    var httpClient: HTTPClient!

    func stats() -> Promise<Stats> {
        return Promise<Stats> { seal in
            guard let githubURL = URL(string: "https://raw.githubusercontent.com/pvieito/RadarCOVID-Report/master") else { seal.reject(HTTPClientError.invalidBaseURL); return }
            let httpClientConfiguration = HTTPClientConfiguration(baseURL: githubURL)
            httpClient.configure(using: httpClientConfiguration)
            
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
