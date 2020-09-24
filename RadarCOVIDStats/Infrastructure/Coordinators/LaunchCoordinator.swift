//
//  LaunchCoordinator.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import UIKit

protocol LaunchCoordinator {
    var application: UIApplication? { get set }
    var window: UIWindow { get }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
}

class LaunchCoordinatorDefault: LaunchCoordinator {
    var application: UIApplication?
    lazy var window = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.application = application
        defineInitialModule()
        window.makeKeyAndVisible()
        return true
    }

    internal func defineInitialModule() {
        window.backgroundColor = .black
        window.rootViewController = MainBuilder.build.controller
    }
}
