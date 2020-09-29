//
//  PresentationContainer.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Swinject

class CoordinatorsContainer {
    @discardableResult
    init(container: Container) { prepareInjections(container: container) }

    internal func prepareInjections(container: Container) {
        container.register(LaunchCoordinator.self) { resolver in
            var coordinator = LaunchCoordinatorDefault()
            coordinator.networkService = resolver.resolve(NetworkService.self)
            return coordinator
        }.inObjectScope(.container)
        
        container.register(SystemCoordinator.self) { _ in SystemCoordinatorDefault() }.inObjectScope(.container)
    }
}
