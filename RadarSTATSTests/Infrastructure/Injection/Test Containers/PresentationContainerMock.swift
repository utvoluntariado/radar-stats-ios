//
//  PresentationContainerMock.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 30/09/2020.
//

import Swinject

@testable import Radar_STATS

class PresentationContainerMock {
    @discardableResult
    init(container: Container) { prepareInjections(container: container) }

    internal func prepareInjections(container: Container) {
        container.register(ChartsRouter.self) { _ in ChartsRouterDefault() }.inObjectScope(.container)
        container.register(ChartsPresenter.self) { _ in ChartsPresenterTestable() }.inObjectScope(.container)
    }
}

