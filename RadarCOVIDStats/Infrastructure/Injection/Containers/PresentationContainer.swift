//
//  PresentationContainer.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 23/09/2020.
//

import Swinject

class PresentationContainer {
    @discardableResult
    init(container: Container) { prepareInjections(container: container) }

    internal func prepareInjections(container: Container) {
        container.register(ChartsPresenter.self) { _ in ChartsPresenterDefault() }.inObjectScope(.container)
        container.register(ChartsFactory.self) { _ in ChartsFactoryDefault() }.inObjectScope(.container)
    }
}
