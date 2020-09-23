//
//  MainPresenter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 23/09/2020.
//

import Foundation

protocol MainPresenter {
    var view: MainView! { get set }
    var router: MainRouter! { get set }
}

final class MainPresenterDefault: MainPresenter {
    var view: MainView!
    var router: MainRouter!
}
