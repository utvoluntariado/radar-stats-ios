//
//  AppDelegate.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 23/09/2020.
//

import UIKit

protocol MainView {
    var presenter: MainPresenter! { get set }
}

class MainViewController: UITabBarController, MainView {
    var presenter: MainPresenter!
}
