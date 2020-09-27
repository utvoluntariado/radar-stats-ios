//
//  ChartsRouter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import Foundation

enum ChartsScene {
    case info(chartType: ChartType)
}

protocol ChartsRouter: class {
    var viewController: ChartsViewController! { get set }

    func navigate(to scene: ChartsScene)
}

class ChartsRouterDefault: ChartsRouter {
    var viewController: ChartsViewController!

    func navigate(to scene: ChartsScene) {
        switch scene {
        case .info(let type): presentInfo(for: type)
        }
    }

    private func presentInfo(for chartType: ChartType) {
        
    }
}
