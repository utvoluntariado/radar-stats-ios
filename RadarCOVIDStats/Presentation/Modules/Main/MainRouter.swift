//
//  MainRouter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 23/09/2020.
//

import Foundation

enum MainScene {
    case stats
    case about
}

protocol MainRouter {
    var viewController: MainViewController! { get set }

    func navigate(to scene: MainScene)
}

final class MainRouterDefault: MainRouter {
    var viewController: MainViewController!

    func navigate(to scene: MainScene) {
        
    }
}
