//
//  PresentationContainer.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import Swinject

class CoordinatorsContainer {
    @discardableResult
    init(container: Container) { prepareInjections(container: container) }

    internal func prepareInjections(container: Container) {
        container.register(LaunchCoordinator.self) { _ in LaunchCoordinatorDefault() }.inObjectScope(.container)
    }
}
