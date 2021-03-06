//
//  ServicesContainer.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Swinject

class ServicesContainer {
    @discardableResult
    init(container: Container) { prepareInjections(container: container) }

    internal func prepareInjections(container: Container) {
        container.register(StorageService.self) { _ in StorageServiceDefault() }.inObjectScope(.container)
        container.register(NetworkService.self) { _ in NetworkServiceDefault() }.inObjectScope(.container)
    }
}
