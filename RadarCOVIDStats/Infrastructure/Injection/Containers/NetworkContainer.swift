//
//  NetworkContainer.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on24/09/2020.
//

import Swinject

class NetworkContainer {
    @discardableResult
    init(container: Container) { prepareInjections(container: container) }

    internal func prepareInjections(container: Container) {
        container.register(HTTPClient.self) { _ in HTTPClientDefault() }.inObjectScope(.container)
    }
}
