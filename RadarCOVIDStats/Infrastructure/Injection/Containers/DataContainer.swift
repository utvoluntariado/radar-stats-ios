//
//  DataContainer.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import Swinject

class DataContainer {
    @discardableResult
    init(container: Container) { prepareInjections(container: container) }

    internal func prepareInjections(container: Container) {
        container.register(StatsRepository.self) { resolver in
            let repository = StatsRepositoryDefault()
            repository.httpClient = resolver.resolve(HTTPClient.self)
            return repository
        }
    }
}
