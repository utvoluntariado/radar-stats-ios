//
//  MainView.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 23/09/2020.
//

import UIKit

protocol MainView {

}

class MainViewController: UITabBarController, MainView {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [ChartsBuilder.build.controller, AboutBuilder.build.controller]
        tabBar.clipsToBounds = true
    }
}
