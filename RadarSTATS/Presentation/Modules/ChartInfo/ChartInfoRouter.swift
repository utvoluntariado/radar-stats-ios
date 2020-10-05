//
//  ChartInfoRouter.swift
//  RadarSTATS
//
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import Foundation

enum ChartInfoScene {
    case dismiss
}

protocol ChartInfoRouter: class {
    var viewController: ChartInfoViewController! { get set }

    func navigate(to scene: ChartInfoScene)
}

class ChartInfoRouterDefault: ChartInfoRouter {
    var viewController: ChartInfoViewController!

    func navigate(to scene: ChartInfoScene) {
        switch scene {
        case .dismiss: viewController?.dismiss(animated: true, completion: nil)
        }
    }
}

