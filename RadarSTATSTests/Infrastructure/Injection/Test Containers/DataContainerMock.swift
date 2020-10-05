//
//  DataContainerMock.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 30/09/2020.
//

import Swinject

@testable import Radar_STATS

class DataContainerMock {
    @discardableResult
    init(container: Container) { prepareInjections(container: container) }

    internal func prepareInjections(container: Container) {
        container.register(StatsRepository.self) { _ in StatsRepositoryMock() }.inObjectScope(.container)
        container.register(LocalizationRepository.self) { _ in LocalizationRepositoryMock() }.inObjectScope(.container)
    }
}

