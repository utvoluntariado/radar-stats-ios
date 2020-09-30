//
//  AppDelegate.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 23/09/2020.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    let launchCoordinator = <~LaunchCoordinator.self

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return launchCoordinator.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
