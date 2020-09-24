//
//  ChartsPresenter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import Foundation

protocol ChartsPresenter {
    var view: ChartsView! { get set }
}

final class ChartsPresenterDefault: ChartsPresenter {
    var view: ChartsView!
}
