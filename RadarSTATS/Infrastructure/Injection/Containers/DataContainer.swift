//
//  DataContainer.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Swinject

class DataContainer {
    @discardableResult
    init(container: Container) { prepareInjections(container: container) }

    internal func prepareInjections(container: Container) {
        container.register(StatsRepository.self) { resolver in
            let repository = StatsRepositoryDefault()
            repository.httpClient = resolver.resolve(HTTPClient.self)
            repository.storageService = resolver.resolve(StorageService.self)
            repository.networkService = resolver.resolve(NetworkService.self)
            return repository
        }
    }
}
