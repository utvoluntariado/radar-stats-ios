//
//  Injector.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 23/09/2020.
//

import Foundation
import Swinject

final class Injector {
    static let shared = Injector()
    internal var currentContainer = Container()

    init() {
        CoordinatorsContainer(container: currentContainer)
        BusinessContainer(container: currentContainer)
        NetworkContainer(container: currentContainer)
        DataContainer(container: currentContainer)
        PresentationContainer(container: currentContainer)
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

