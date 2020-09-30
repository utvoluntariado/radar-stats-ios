//
//  AboutRouter.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import Foundation

enum AboutScene {
    case dismiss
}

protocol AboutRouter: class {
    var viewController: AboutViewController! { get set }

    func navigate(to scene: AboutScene)
}

class AboutRouterDefault: AboutRouter {
    var viewController: AboutViewController!

    func navigate(to scene: AboutScene) {
        switch scene {
        case .dismiss: viewController?.dismiss(animated: true, completion: nil)
        }
    }
}

