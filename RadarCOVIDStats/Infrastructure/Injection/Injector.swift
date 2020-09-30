//
//  Injector.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 23/09/2020.
//

import Foundation
import Swinject

final class Injector {
    static let shared = Injector()
    internal var currentContainer = Container()
    private let defaultContainer = Container()

    init() {
        CoordinatorsContainer(container: currentContainer)
        ServicesContainer(container: currentContainer)
        BusinessContainer(container: currentContainer)
        NetworkContainer(container: currentContainer)
        DataContainer(container: currentContainer)
        PresentationContainer(container: currentContainer)
    }

    func use(container: Container) {
        currentContainer = container
    }

    func resetContainer() {
        currentContainer = defaultContainer
    }
}

prefix operator <~
prefix func <~<Injection>(right: Injection.Type) -> Injection {
    if let registeredInjection = Injector.shared.currentContainer.resolve(Injection.self) {
        return registeredInjection
    } else {
        fatalError("Cannot resolve \(Injection.self)")
    }
}

