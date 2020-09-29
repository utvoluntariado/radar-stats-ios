//
//  BusinessContainer.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Swinject

class BusinessContainer {
    @discardableResult
    init(container: Container) { prepareInjections(container: container) }

    internal func prepareInjections(container: Container) {
        container.register(StatsInteractor.self) { resolver in
            let interactor = StatsInteractorDefault()
            interactor.repository = resolver.resolve(StatsRepository.self)
            return interactor
        }
    }
}
