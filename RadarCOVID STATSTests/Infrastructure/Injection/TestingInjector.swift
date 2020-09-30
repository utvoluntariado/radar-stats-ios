//
//  TestInjector.swift
//  RadarCOVID STATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 30/09/2020.
//

import Foundation
import Swinject

@testable import RadarCOVID_STATS

final class TestingInjector {
    static func prepareMockInjections() {
        let mockContainer = Container()

        Injector.shared.use(container: mockContainer)
    }

    static func resetInjections() {
        Injector.shared.resetContainer()
    }
}

