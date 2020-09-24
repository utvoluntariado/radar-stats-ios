//
//  AppDelegate.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 23/09/2020.
//

import UIKit

protocol MainView {

}

class MainViewController: UITabBarController, MainView {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [ChartsBuilder.build.controller]
        tabBar.clipsToBounds = true
    }
}
