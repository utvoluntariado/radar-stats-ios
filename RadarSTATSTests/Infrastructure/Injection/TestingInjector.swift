//
//  TestInjector.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 30/09/2020.
//

import Foundation
import Swinject

@testable import RadarSTATS

final class TestingInjector {
    static func prepareMockInjections() {
        let mockContainer = Container()
        CoordinatorsContainer(container: mockContainer)
        ServicesContainer(container: mockContainer)
        BusinessContainer(container: mockContainer)
        NetworkContainer(container: mockContainer)
        PresentationContainerMock(container: mockContainer)
        DataContainerMock(container: mockContainer)
        Injector.shared.use(container: mockContainer)
    }

    static func resetInjections() {
        Injector.shared.resetContainer()
    }
}

