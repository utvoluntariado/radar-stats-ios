//
//  LaunchCoordinator.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
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
        prepareBasicAppearances()
        defineInitialModule()
        window.makeKeyAndVisible()
        return true
    }

    internal func defineInitialModule() {
        window.backgroundColor = .black
        window.rootViewController = MainBuilder.build.controller
    }

    private func prepareBasicAppearances() {
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)], for: .normal)
    }
}
